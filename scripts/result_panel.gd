extends Panel
class_name ResultPanel

@onready var full_text := $DialogueText/FullText
@onready var display_text := $DialogueText/DisplayText

var insertion_text := ""
var displayed_chars := 0
var typing_speed := .05
var timer := 0.0
var is_typing := false

func start_dialog(text: String) -> void:
	insertion_text = text
	displayed_chars = 0
	is_typing = true
	timer = 0.0
	
	# Label invisible berisi teks penuh → mengunci lebar
	full_text.text = full_text
	full_text.modulate.a = 0.0  # transparan tapi tetap occupies space
	
	# Label visible mulai kosong
	display_text.text = ""

func _process(delta: float) -> void:
	if not is_typing:
		return
	
	timer += delta
	if timer >= typing_speed:
		timer = 0.0
		_type_next_char()

func _type_next_char() -> void:
	if displayed_chars >= full_text.length():
		is_typing = false
		return
	
	displayed_chars += 1
	display_text.text = full_text.substr(0, displayed_chars)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			# Skip → tampilkan semua sekaligus
			is_typing = false
			display_text.text = full_text
		else:
			# Lanjut dialog berikutnya
			pass
