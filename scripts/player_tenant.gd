extends Node2D
class_name PlayerTenant

static var Instance: PlayerTenant

@onready var ready_menu_icon := $ReadyMenu/MenuIcon

var is_menu_ready := false

func _enter_tree() -> void:
	Instance = self
	
func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	if Conductor.Instance != null:
		Conductor.Instance.menu_complete.connect(dish_ready)
		Conductor.Instance.track_changed.connect(track_changed)
		
	ready_menu_icon.hide()

func dish_ready(ready_menu: ReadyMenu):
	is_menu_ready = true
	ready_menu_icon.show()
	
	ready_menu_icon.texture = ready_menu.menu.icon
	
func track_changed(menu: Menu):
	is_menu_ready = false
	
	ready_menu_icon.hide()
