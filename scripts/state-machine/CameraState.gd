extends State
class_name CameraState 

@export var action_name: String
@export var drag_speed: float
@export var camera_limit_left: float
@export var camera_limit_right: float

func _ready() -> void:
	Paralax.Instance.camera_move.connect(change_state_to_self)

func Input_Handler(_event: InputEvent):
	pass

func change_state_to_self() -> void:
	print("Ubah State")
	Transitioned.emit(self, "CameraState")
