extends Node2D

class_name Note

@export var ingridient: Ingridient

var spawn_pos: Vector2
var target_pos: Vector2

@export var speed = 20

var process := 0.0

func _process(delta: float) -> void:
	process += speed * delta
	process = clamp(process, 0, 1)
	position = spawn_pos.lerp(target_pos, process)

func initialize(spawn_pos: Vector2, targetF: Vector2):
	spawn_pos = position
	target_pos = targetF
