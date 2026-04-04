extends Node2D
class_name PlayerTenant

@onready var ready_menu_icon := $ReadyMenu/MenuIcon

var is_menu_ready := false

func _ready() -> void:
	if Conductor.Instance != null:
		Conductor.Instance.menu_complete.connect(dish_ready)

func dish_ready(ready_menu: ReadyMenu):
	is_menu_ready = true
	
	# icon is already change before the last note arrive
	ready_menu_icon.texture = ready_menu.menu.icon
