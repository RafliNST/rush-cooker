extends Node2D

class_name NoteSpawner

@export var note_scene: PackedScene

@onready var left_lane: Lane = $LeftLane
@onready var center_lane: Lane = $CenterLane
@onready var right_lane: Lane = $RightLane

@onready var left_lane_target := $LeftLane/TargetPos
@onready var center_lane_target := $CenterLane/TargetPos
@onready var right_lane_target := $RightLane/TargetPos

func _ready() -> void:
	var rhythm_state = StateMachine.get_node("RhythmState")
	
	rhythm_state.left_action.connect(left_lane.action_pressed)
	rhythm_state.center_action.connect(center_lane.action_pressed)
	rhythm_state.right_action.connect(right_lane.action_pressed)

func _exit_tree() -> void:
	var rhythm_state = StateMachine.get_node("RhythmState")
	
	rhythm_state.left_action.disconnect(left_lane.action_pressed)
	rhythm_state.center_action.disconnect(center_lane.action_pressed)
	rhythm_state.right_action.disconnect(right_lane.action_pressed)

func _on_conductor_music_beat(number: int, item: MenuItem) -> void:
	if item.lane_pos.has(Menu.LanePosition.LEFT):
		var note = note_scene.instantiate()
		left_lane.add_child(note)
		note.initialize(item.ingridient, number,left_lane_target.position)
		
		left_lane.notes.append(note)
		print("Left Added: " + str(left_lane.notes.size()))
	if item.lane_pos.has(Menu.LanePosition.CENTER):
		var note = note_scene.instantiate()
		center_lane.add_child(note)
		note.initialize(item.ingridient, number,center_lane_target.position)
		
		center_lane.notes.append(note)
		print("Center Added: " + str(left_lane.notes.size()))
	if item.lane_pos.has(Menu.LanePosition.RIGHT):
		var note = note_scene.instantiate()
		right_lane.add_child(note)
		note.initialize(item.ingridient, number,right_lane_target.position)
		
		right_lane.notes.append(note)
		print("Right Added: " + str(left_lane.notes.size()))
