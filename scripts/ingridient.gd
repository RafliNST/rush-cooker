extends Node2D

class_name Note

@onready var sprite_renderer := $Icon
@onready var audio_output := $AudioOutput

var spawn_pos: Vector2
var target_pos: Vector2

var ingridient: Ingridient
var beat_number := 0

var process := 0.0

func _process(delta: float) -> void:
	process = beat_number - Conductor.get_current_beat_pos()
	process = clamp(process, 0,1)
	position = target_pos.lerp(spawn_pos, process)

func initialize(item: Ingridient, number: int, targetF: Vector2):
	ingridient = item
	beat_number = number
	
	sprite_renderer.texture = item.sprite
	audio_output.stream = item.SFX
	
	spawn_pos = position
	target_pos = targetF
