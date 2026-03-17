extends Node2D

class_name Conductor

signal track_changed
signal music_beat(beat_number: int)

static var Instance: Conductor

@export var offset := 1.0

@export var current_menu: Menu
@export var other_menu: Menu

@onready var audio_player := $AudioStream
@onready var note_timer := $NoteTimer

@export var note_scene: PackedScene

var beat_number := 0
var beat_arr_pos := 0

func _enter_tree() -> void:
	Instance = self
	
func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	change_track(current_menu)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		change_track(other_menu)

func get_music_progress() -> float:
	return audio_player.get_playback_position()
	
func get_current_beat_pos() -> float:
	return get_music_progress() / (note_timer.wait_time * offset)

func setup_timer():
	note_timer.wait_time = 60.0 / current_menu.BPM
	print("Wait Time: " + str(note_timer.wait_time))
	note_timer.start()

func play_music():
	audio_player.stream = current_menu.BGM
	audio_player.play()

func change_track(menu: Menu):
	beat_number = 0
	beat_arr_pos = 0
	
	current_menu = menu
	note_timer.wait_time = current_menu.BPM / 60.0
	
	setup_timer()
	play_music()
	track_changed.emit()

func _on_timeout() -> void:
	if beat_arr_pos < current_menu.ingredients.size():
		music_beat.emit(beat_number)
	beat_number += 1
