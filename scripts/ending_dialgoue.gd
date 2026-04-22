extends Panel
class_name EndingDialogue

@onready var display_text := $DialogueText/DisplayText

@export var text_speed := .05
#@export var timer_before_next := .3
@export var height_per_line := 40
@export_multiline var text: String

var sentences: Array[String]

var is_typing := false
var timer_text := 0.0

var substr_idx := 0
var current_text_idx := -1

func _ready() -> void:
	load_string_to_array(text)
	
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
	
	display_text.text += sentences[current_text_idx].substr(substr_idx, 1)
	substr_idx += 1
	
func change_text() -> void:
	if current_text_idx+1 >= sentences.size():
		return
	
	current_text_idx += 1
	substr_idx = 0
	
	is_typing = true
