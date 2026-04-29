extends Node2D
class_name  MainMenu

@onready var player_condition := $MenuLayer/Panel/TextureRect

@export var default_txt: Texture
@export var on_win_txt: Texture2D
@export var on_lose_txt: Texture2D

func _ready() -> void:
	SettingsLayer.hide()
	
	player_condition.texture = default_txt
	
	if StateMachine.save_file.is_win:
		player_condition.texture = on_win_txt
	elif StateMachine.save_file.unhandled_customer_too_many or \
		StateMachine.save_file.is_bankrupt:
		player_condition.texture = on_lose_txt

func _on_newgame_pressed() -> void:
	StateMachine.save_file.reset_stat()
	get_tree().change_scene_to_file("res://scenes/UIs/ending_dialogue.tscn")

func _on_settings_pressed() -> void:
	SettingsLayer.show()
