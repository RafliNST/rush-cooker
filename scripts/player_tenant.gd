extends Node2D
class_name PlayerTenant

static var Instance: PlayerTenant

@onready var ready_menu_icon := $MenuIcon
@onready var player_animated_sprite := $PlayerSprite

var menu_performane := 0.0

func _enter_tree() -> void:
	Instance = self
	
func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	if Conductor.Instance != null:
		NoteSpawner.Instance.menu_complete.connect(dish_ready)
		Conductor.Instance.track_changed.connect(track_changed)
	if Paralax.Instance != null:
		Paralax.Instance.camera_move.connect(animation_to_idle)
		Paralax.Instance.camera_to_center.connect(animation_to_cook)
		
	ready_menu_icon.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("end_day"):
		if CustomerManager.Instance.spawn_point_children_sum != 1:
			return
		
		DayCycle.Instance.day_finished.emit()

func dish_ready() -> void:
	ready_menu_icon.show()
	menu_performane = float(ScoreManager.Instance.current_score) / \
		Conductor.Instance.current_menu.max_score
	
func track_changed(menu: Menu) -> void:
	ready_menu_icon.hide()
	ready_menu_icon.texture = menu.icon
	
func animation_to_idle() -> void:
	player_animated_sprite.play("idle")
	
func animation_to_cook() -> void:
	player_animated_sprite.play("cooking")
