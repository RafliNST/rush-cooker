extends State
class_name RhythmState 

@export var left_action_name	: String
@export var center_action_name	: String
@export var right_action_name	: String

signal left_action
signal center_action
signal right_action

func _ready() -> void:
	if Paralax.Instance != null:
		Paralax.Instance.camera_to_center.connect(change_state_to_self)

func Input_Handler(_event: InputEvent):
	if _event.is_action_pressed(left_action_name):
		left_action.emit()
	if _event.is_action_pressed(center_action_name):
		center_action.emit()
	if _event.is_action_pressed(right_action_name):
		right_action.emit()

func change_state_to_self() -> void:
	Transitioned.emit(self, "RhythmState")
