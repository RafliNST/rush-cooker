extends Node2D

class_name Lane

signal on_note_beat(lane: Menu.LanePosition, shot: AudioStream)

@export var audio : AudioStream
@export var action_name : String

@export var lane_position: Menu.LanePosition

var notes: Array[Note]

func action_pressed():
	if notes.size() > 0:
			notes[0].audio_output.play()
