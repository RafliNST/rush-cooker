extends Node2D

class_name NoteSpawner

@export var note_scene: PackedScene

@onready var left_lane: Lane = $LeftLane
@onready var center_lane: Lane = $CenterLane
@onready var right_lane: Lane = $RightLane

@onready var left_lane_target := $LeftLane/TargetPos
@onready var center_lane_target := $CenterLane/TargetPos
@onready var right_lane_target := $RightLane/TargetPos

func _on_conductor_music_beat(number: int, item: MenuItem) -> void:
	
	if item.lane_pos.has(Menu.LanePosition.LEFT):
		var note = note_scene.instantiate()
		note.initialize(left_lane.position, left_lane_target.position)
		left_lane.add_child(note)
	if item.lane_pos.has(Menu.LanePosition.CENTER):
		var note = note_scene.instantiate()
		note.initialize(center_lane.position, center_lane_target.position)
		center_lane.add_child(note)
	if item.lane_pos.has(Menu.LanePosition.RIGHT):
		var note = note_scene.instantiate()
		note.initialize(right_lane.position, right_lane_target.position)
		right_lane.add_child(note)
