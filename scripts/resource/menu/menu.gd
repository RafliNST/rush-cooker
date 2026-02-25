extends Resource

class_name Menu

enum LanePosition { LEFT, CENTER, RIGHT }

@export var name: String
@export var icon: Texture2D
@export var BGM: AudioStream
@export var BPM: int
@export var ingridients: Array[MenuItem]
