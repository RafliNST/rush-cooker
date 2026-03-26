extends CanvasLayer

@onready var selector_container := $Control/VBoxContainer

@export var menu_selector : PackedScene
@export var menus : Array[Menu]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for menu in menus:
		var selector = menu_selector.instantiate()
		selector_container.add_child(selector)
		selector.initialize(menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
