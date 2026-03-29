extends Camera2D
class_name Paralax

var is_dragging := false
var drag_start_x := 0.0
var camera_start_x := 0.0

signal camera_move
signal camera_to_center

static var Instance: Paralax

var is_back_to_target := false
@onready var target_object := $"../PlayerTenant"

@export var drag_speed := 3.0
@export var limit_left_custom := -300.0
@export var limit_right_custom := 300.0

func _enter_tree() -> void:
	Instance = self
	
func _exit_tree() -> void:
	Instance = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_dragging = event.pressed
		drag_start_x = event.position.x
		camera_start_x = position.x
		
		
	if event is InputEventMouseMotion and is_dragging:
		var delta_x = (event.position.x - drag_start_x) * drag_speed
		position.x  = clamp(camera_start_x - delta_x, limit_left_custom, limit_right_custom)
		if StateMachine.current_state is not CameraState:
			camera_move.emit()

func _process(delta: float) -> void:
	if is_back_to_target:
		move_camera_to_target(delta)

func move_camera_to_target(delta: float) -> void:
	position.x = move_toward(position.x, target_object.position.x, 5000 * delta)
		
	if abs(position.x - target_object.position.x) < 1.0:
		position.x = target_object.position.x
		is_back_to_target = false
		camera_to_center.emit()

func _on_button_pressed() -> void:
	is_back_to_target = true
