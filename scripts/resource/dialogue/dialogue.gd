extends Resource
class_name Dialogue

@export var sentence: Array[String]
@export var new_line_after: Array[int]
@export var new_line_before: Array[int]

var display_min_height: int:
	get:
		return 40 * (new_line_after.size() + new_line_before.size())
