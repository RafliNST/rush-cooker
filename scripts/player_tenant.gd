extends Node2D
class_name PlayerTenant

static var Instance: PlayerTenant

@onready var ready_menu_icon := $ReadyMenu/MenuIcon

var menu_performane := 0.0

func _enter_tree() -> void:
	Instance = self
	
func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	if Conductor.Instance != null:
		Conductor.Instance.menu_complete.connect(dish_ready)
		Conductor.Instance.track_changed.connect(track_changed)
		
	ready_menu_icon.hide()

func dish_ready(ready_menu: Menu):
	ready_menu_icon.show()
	
	menu_performane = ScoreManager.Instance.current_score / ready_menu.max_score
	
	ready_menu_icon.texture = ready_menu.icon
	
func track_changed(menu: Menu):
	ready_menu_icon.hide()
