extends Node2D

class_name NoteSpawner

@onready var left_lane: Lane = $LeftLane
@onready var center_lane: Lane = $CenterLane
@onready var right_lane: Lane = $RightLane

func _ready() -> void:
	var rhythm_state = StateMachine.get_node("RhythmState")
	
	rhythm_state.left_action.connect(left_lane.action_pressed)
	rhythm_state.center_action.connect(center_lane.action_pressed)
	rhythm_state.right_action.connect(right_lane.action_pressed)
	
	Conductor.Instance.music_beat.connect(left_lane.spawn_note)
	Conductor.Instance.music_beat.connect(center_lane.spawn_note)
	Conductor.Instance.music_beat.connect(right_lane.spawn_note)

func _exit_tree() -> void:
	var rhythm_state = StateMachine.get_node("RhythmState")
	
	rhythm_state.left_action.disconnect(left_lane.action_pressed)
	rhythm_state.center_action.disconnect(center_lane.action_pressed)
	rhythm_state.right_action.disconnect(right_lane.action_pressed)

func _on_conductor_track_changed(menu: Menu) -> void:
	left_lane.notes.clear()
	center_lane.notes.clear()
	right_lane.notes.clear()
	
	for item in Conductor.Instance.current_menu.ingredients:
		if item.lane_pos == Menu.LanePosition.LEFT:
			left_lane.notes[item.beat_number] = item
		elif item.lane_pos == Menu.LanePosition.CENTER:
			center_lane.notes[item.beat_number] = item
		else:
			right_lane.notes[item.beat_number] = item
