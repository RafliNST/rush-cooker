extends Panel
class_name EndingDialogue

@onready var display_text := $DialogueText/DisplayText
@onready var audio_player := $AudioPlayer

@export var text_speed := .05
@export var height_per_line := 40
@export var main_scene_path: PackedScene

#region Ending Dialogue
@export var income_met: DialogueParagraph
@export var irresponsible: DialogueParagraph
@export var irresponsibe_after: DialogueParagraph
@export var many_customer: DialogueParagraph
@export var perfect_hits: DialogueParagraph
@export var high_combo: DialogueParagraph
#endregion

#region Ending Threshold
@export var income_minimum := 15000
@export var max_irresponsible := 7
@export var min_customer := 12
@export var min_perfect := 15
@export var min_combo := 15
#endregion

var is_continue := true

var text := """Libur semester baru saja dimulai. Tapi pikiranku sudah jauh ke depan,
ke tagihan yang belum terbayar dan saldo yang tidak bertambah.

Aku pernah kerja sambilan di warung nasi goreng dekat
kampus, semester dua. Hanya tiga bulan. Hanya bantu-bantu.
Tapi cukup lama untuk tahu cara kerja dapurnya.

Cara pegang wajan yang benar supaya pergelangan tidak cepat pegal.
Urutan bumbu yang masuk. Kapan telur diaduk, kapan dibiarkan.
Waktu itu aku pikir itu hanya pekerjaan sementara.

Sekarang aku sadar, tiga bulan itu adalah
pelatihan yang tidak pernah aku rencanakan"""
var sentences: Array[String]

var is_typing := false
var timer_text := 0.0

var substr_idx := 0
var current_text_idx := -1

func _ready() -> void:
	select_ending()
	load_string_to_array(text)
	audio_player.play()
	
	display_text.text += "[p][center]"
	
func _process(delta: float) -> void:
	if is_typing:
		timer_text += delta
	
		if timer_text > text_speed:
			timer_text = 0
			render_text(delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			return
			
		change_text()

func select_ending() -> void:
	if StateMachine.save_file.unhandled_customer_too_many:
		text = irresponsibe_after.paragraph
		is_continue = false
		return
	
	if StateMachine.save_file.incomes >= income_minimum:
		text = income_met.paragraph
		audio_player.stream = income_met.bgm
		
		is_continue = false
		
		StateMachine.save_file.is_win = true
		StateMachine.save_file.is_bankrupt = false
		StateMachine.save_file.unhandled_customer_too_many = false
		
	elif StateMachine.save_file.unhandled_customer >= max_irresponsible:
		text = irresponsible.paragraph
		audio_player.stream = irresponsible.bgm
		
		StateMachine.save_file.unhandled_customer_too_many = true
		StateMachine.save_file.is_win = false
		StateMachine.save_file.is_bankrupt = false
		
	elif StateMachine.save_file.handled_customer >= min_customer:
		text = many_customer.paragraph
		audio_player.stream = many_customer.bgm
	elif StateMachine.save_file.perfect_hit >= min_perfect:
		text = perfect_hits.paragraph
		audio_player.stream = perfect_hits.bgm
	elif StateMachine.save_file.best_combo >= min_combo:
		text = high_combo.paragraph
		audio_player.stream = high_combo.bgm

func load_string_to_array(l: String) -> void:
	for line in l.split("."):
		sentences.append(line)
	
	display_text.custom_minimum_size = Vector2(0, 
		height_per_line * sentences.size())

func render_text(delta: float) -> void:
	if substr_idx >= sentences[current_text_idx].length():
		if substr_idx == sentences[current_text_idx].length():
			display_text.text += ". "
			substr_idx += 1
		
		is_typing = false
		return
	
	display_text.text += sentences[current_text_idx] \
		.substr(substr_idx, 1)
	substr_idx += 1
	
func change_text() -> void:
	if current_text_idx+1 >= sentences.size():
		if is_continue:
			get_tree().change_scene_to_packed(main_scene_path)
		else:
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		return
	
	current_text_idx += 1
	substr_idx = 0
	
	is_typing = true
