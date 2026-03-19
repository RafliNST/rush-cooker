extends Node2D

class_name Lane

signal on_note_beat(lane: Menu.LanePosition, shot: AudioStream)

@export var audio : AudioStream
@export var action_name : String

@export var lane_position: Menu.LanePosition

@onready var target_pos := $TargetPos
@onready var audio_stream := $AudioStream
@onready var notes_collection := $NotesCollection

var notes: Dictionary

func action_pressed():
	if notes_collection.get_child_count() > 0:
		notes_collection.get_child(0).play_beat()

func spawn_note(beat_number: int):	
	if notes.has(beat_number):
		var note = Conductor.Instance.note_scene.instantiate()
		notes_collection.add_child(note)
		note.initialize(notes[beat_number].ingridient, beat_number,target_pos.position)
