extends Timer

signal track_changed

@export var current_menu: Menu
@export var other_menu: Menu

@onready var audio_player := $AudioStreamPlayer2D

signal music_beat(beat_number: int, item: MenuItem)

var beat_number := 0
var beat_arr_pos := 0

func _ready() -> void:
	if current_menu != null:
		play_music()
		setup_timer()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		change_track(other_menu)
	
func get_music_progress() -> float:
	return audio_player.get_playback_position()	

func setup_timer():
	wait_time = 60.0 / current_menu.BPM
	start()
	
func play_music():
	audio_player.stream = current_menu.BGM
	audio_player.play()
	
func change_track(menu: Menu):
	beat_number = 0
	beat_arr_pos = 0
	
	current_menu = menu
	wait_time = 60.0 / current_menu.BPM
	
	play_music()
	start()
	track_changed.emit()

func _on_timeout() -> void:
	if beat_arr_pos < current_menu.ingredients.size():
		if beat_number == current_menu.ingredients[beat_arr_pos].beat_number:
			music_beat.emit(beat_number, current_menu.ingredients[beat_arr_pos])
			beat_arr_pos += 1
	beat_number += 1
