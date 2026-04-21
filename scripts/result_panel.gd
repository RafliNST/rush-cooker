extends Panel
class_name ResultPanel

@onready var display_text := $DialogueText/CenterContainer/DisplayText
@export var save_file: SaveFile
@export var text_speed := 0.05
@export var dialogues: Array[Dialogue]

var text_idx := -1
var sub_text_idx := 0
var is_typing := false
var timer := 0.0

func _ready() -> void:
	display_text.bbcode_enabled = true
	display_text.text = "[p][center]"

func _process(delta: float) -> void:
	if is_typing:
		render_text(delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if is_typing or text_idx >= dialogues.size() - 1:
			return

		text_idx += 1
		sub_text_idx = 0
		timer = 0.0
		#display_text.text = "[center]"  # clear teks lama
		is_typing = true

func render_text(delta: float) -> void:
	var current_text := dialogues[text_idx]

	if sub_text_idx >= current_text.length():
		if sub_text_idx == current_text.length():
			display_text.text += ". "
		is_typing = false
		return
	

	timer += delta
	if timer >= text_speed:
		timer = 0.0
		display_text.text += current_text.substr(sub_text_idx, 1)
		sub_text_idx += 1
