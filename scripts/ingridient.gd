extends Node2D

class_name Note

@onready var sprite_renderer := $Icon
@onready var audio_output := $AudioOutput
@onready var destroy_timer := $DestroyTimer

enum SCORE_STATE { FORBID = 0, BAD = -3, GOOD = 2, PERFECT = 4 }

var score_state := SCORE_STATE.FORBID

var spawn_pos: Vector2
var target_pos: Vector2

var ingridient: Ingridient
var beat_number := 0

var has_emit := false
var on_destroy := false
var process := 0.0
var note_time := 0.0

var time_diff := 0.0:
	set(value):
		time_diff = value
		
		if time_diff < .05:
			score_state = SCORE_STATE.PERFECT
			on_destroy = true
			destroy_timer.start()
		elif time_diff < .15:
			score_state = SCORE_STATE.GOOD
		elif time_diff < .25:
			score_state = SCORE_STATE.BAD
	get:
		return time_diff

func _process(delta: float) -> void:
	process = (beat_number - Conductor.Instance.get_current_beat_pos()) / Conductor.Instance.offset
	process = clamp(process, 0,1)
	position = target_pos.lerp(spawn_pos, process)
	
	time_diff = abs(note_time - Conductor.Instance.get_music_progress())

func initialize(item: Ingridient, number: int, targetF: Vector2):
	ingridient = item
	beat_number = Conductor.Instance.offset + number
	
	sprite_renderer.texture = item.sprite
	audio_output.stream = item.SFX
	
	spawn_pos = position
	target_pos = targetF
	
	destroy_timer.wait_time = .23
	
	note_time = beat_number * Conductor.Instance.note_timer.wait_time	

func play_beat():
	if score_state == SCORE_STATE.FORBID:
		return
	
	has_emit = true
	audio_output.play()
	destroy_timer.start()

func _on_destroy_timer_timeout() -> void:
	#ScoreManager.Instance.beat_triggered.emit(score_state if has_emit else SCORE_STATE.BAD)
	ScoreManager.Instance.beat_triggered.emit(score_state)
	queue_free()
