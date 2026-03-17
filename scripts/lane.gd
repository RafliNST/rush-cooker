extends Node2D

class_name Lane

signal on_note_beat(lane: Menu.LanePosition, shot: AudioStream)

@export var audio : AudioStream
@export var action_name : String

@export var lane_position: Menu.LanePosition

@onready var target_pos := $TargetPos
@onready var audio_stream := $AudioStream
var notes: Dictionary

func action_pressed():
	if notes.size() > 0:
		audio_stream.stream = notes.values()[0].ingridient.SFX
		audio_stream.play()
			
func spawn_note(beat_number: int):	
	if notes.has(beat_number):
		print("Spawn Pada: " + self.name + " : " + str(beat_number))
		var note = Conductor.Instance.note_scene.instantiate()
		add_child(note)
		note.initialize(notes[beat_number].ingridient, beat_number,target_pos.position)
