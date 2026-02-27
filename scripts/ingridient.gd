extends Node2D

class_name Note

@export var ingridient: Ingridient

var spawn_pos: Vector2
var target_pos: Vector2

@export var speed = 2

var beat_number := 0
var process := 0.0

func _process(delta: float) -> void:
	#process += speed * delta
	#process = clamp(process, 0, 1)
	
	process = beat_number - Conductor.get_current_beat_pos()
	process = clamp(process, 0,1)
	position = target_pos.lerp(spawn_pos, process)
	#position = spawn_pos.lerp(target_pos, process)

func initialize(number: int, targetF: Vector2):
	beat_number = number
	
	spawn_pos = position
	target_pos = targetF	
