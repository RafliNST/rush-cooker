extends Node2D
class_name PlayerTenant

static var Instance: PlayerTenant

@onready var ready_menu_icon := $MenuIcon

var menu_performane := 0.0

func _enter_tree() -> void:
	Instance = self
	
func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	if Conductor.Instance != null:
		NoteSpawner.Instance.menu_complete.connect(dish_ready)
		Conductor.Instance.track_changed.connect(track_changed)
		
	ready_menu_icon.hide()

func dish_ready() -> void:
	ready_menu_icon.show()
	menu_performane = float(ScoreManager.Instance.current_score) / \
		Conductor.Instance.current_menu.max_score
	
	print("Performance: " + str(ScoreManager.Instance.current_score))
	print("Score: " + str(Conductor.Instance.current_menu.max_score))
	
func track_changed(menu: Menu) -> void:
	ready_menu_icon.hide()
	ready_menu_icon.texture = menu.icon
