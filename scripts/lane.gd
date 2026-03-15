extends Node2D

class_name Lane

signal on_note_beat(lane: Menu.LanePosition, shot: AudioStream)

@export var audio : AudioStream
@export var action_name : String

@export var lane_position: Menu.LanePosition

var notes: Array[Note]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action_name):
		if notes.size() > 0:
			notes[0].audio_output.play()
			#self.notes.pop_front()
		
