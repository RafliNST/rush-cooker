extends SubViewport

@export var base_length := 852
@export var extended_length := 1152

enum GROWING_STATE { SHRINK, IDLE, GROW }
@export var growing_state := GROWING_STATE.IDLE
@export var grow_speed := 100

enum ALREADY_MOVED { NO = 1, YES = 2 }
var already_moved := ALREADY_MOVED.NO

func _ready() -> void:
	Paralax.Instance.camera_move.connect(on_camera_unfocus)
	Paralax.Instance.camera_to_center.connect(on_camera_focus)
	
func _process(delta: float) -> void:
	if growing_state != GROWING_STATE.IDLE:
		change_length(delta, growing_state)
		
func on_camera_focus() -> void:
	print("kamera fokus")
	growing_state = GROWING_STATE.SHRINK
	
func on_camera_unfocus() -> void:
	print("kamera tidak fokus")
	growing_state = GROWING_STATE.GROW

func change_length(delta:float, grow_state: GROWING_STATE) -> void:
	var delta_x = grow_speed * delta
	already_moved = ALREADY_MOVED.YES
	
	if grow_state == GROWING_STATE.SHRINK:
		size.x -= delta
		if size.x - base_length == 0:
			growing_state = GROWING_STATE.IDLE
	elif grow_state == GROWING_STATE.GROW:
		size.x += delta_x * already_moved
		if size.x - extended_length == 0:
			growing_state = GROWING_STATE.IDLE
