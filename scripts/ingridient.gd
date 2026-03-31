extends Node2D

class_name Note

@onready var sprite_renderer := $Icon
@onready var destroy_timer := $DestroyTimer

enum SCORE_STATE { FORBID = 0, BAD = -2, GOOD = 2, PERFECT = 4 }

var audio_output: AudioStreamPlayer

var score_state:= SCORE_STATE.FORBID

var spawn_pos: Vector2
var target_pos: Vector2

var ingridient: Ingridient
var beat_number := 0

var has_emit := false

var on_destroy := false
var process := 0.0 :
	set(value):
		process = clamp(value,0,1)
		
		if not on_destroy:
			if process == 0:
				score_state = SCORE_STATE.BAD
				on_destroy = true
				destroy_timer.start()
			elif process < .03:
				score_state = SCORE_STATE.PERFECT
			elif process < .05:
				score_state = SCORE_STATE.GOOD
			elif process < .07:
				score_state = SCORE_STATE.BAD
	get:
		return process

func _process(delta: float) -> void:
	process = (beat_number - Conductor.Instance.get_current_beat_pos()) / Conductor.Instance.beat_delay
	position = target_pos.lerp(spawn_pos, process)

func initialize(item: Ingridient, number: int, targetF: Vector2, audio_stream: AudioStreamPlayer):
	ingridient = item
	beat_number = Conductor.Instance.offset + number
	audio_output = audio_stream
	
	sprite_renderer.texture = item.sprite
	#audio_output.stream = item.SFX
	
	spawn_pos = position
	target_pos = targetF
	
	destroy_timer.wait_time = .23

func play_beat():
	if score_state == SCORE_STATE.FORBID || has_emit:
		return
		
	audio_output.stream = ingridient.SFX
	audio_output.play()
	
	on_destroy = true
	has_emit = true
	ScoreManager.Instance.beat_triggered.emit(score_state if has_emit else SCORE_STATE.BAD)
	
	queue_free()

func _on_destroy_timer_timeout() -> void:
	ScoreManager.Instance.beat_triggered.emit(score_state if has_emit else SCORE_STATE.BAD)
	queue_free()
