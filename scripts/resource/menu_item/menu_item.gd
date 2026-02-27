extends Resource

class_name MenuItem

@export var ingridient: Ingridient
@export var beat_number: int

@export var lane_pos: Array[Menu.LanePosition] = [
	Menu.LanePosition.LEFT, 
	Menu.LanePosition.CENTER,
	Menu.LanePosition.RIGHT, 
]
