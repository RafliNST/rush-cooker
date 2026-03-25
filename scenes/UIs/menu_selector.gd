extends Control

@onready var activator := $ActivatorSelection

@export var menu : Menu

func _ready() -> void:
	if menu == null:
		return
		
	activator.text = menu.name
	activator.icon = menu.icon

func _on_activator_selection_pressed() -> void:
	Conductor.Instance.track_changed.emit(menu)
