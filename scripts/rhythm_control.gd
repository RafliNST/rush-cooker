extends CanvasLayer

@onready var selector_container := $MenuControl/VBoxContainer

@export var menu_selector : PackedScene
@export var menus : Array[Menu]

@export var x_offset := 100
@export var speed := 100.0

enum NODE_VISIBLITY_STATUS { VISIBLE, IDLE, HIDDEN }
var node_visibility := NODE_VISIBLITY_STATUS.IDLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Paralax.Instance != null:
		Paralax.Instance.camera_move.connect(on_camera_focus)
		Paralax.Instance.camera_to_center.connect(on_camera_unfocus)
	
	for menu in menus:
		var selector = menu_selector.instantiate()
		selector_container.add_child(selector)
		selector.initialize(menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if node_visibility != NODE_VISIBLITY_STATUS.IDLE:
		if node_visibility == NODE_VISIBLITY_STATUS.VISIBLE:
			hide_node(delta)
		elif node_visibility == NODE_VISIBLITY_STATUS.HIDDEN:
			show_node(delta)

func on_camera_focus() -> void:
	node_visibility = NODE_VISIBLITY_STATUS.VISIBLE
	
func on_camera_unfocus() -> void:
	node_visibility = NODE_VISIBLITY_STATUS.HIDDEN

func hide_node(delta: float) -> void:
	if offset.x < x_offset:
		offset.x += speed * delta
	else:
		node_visibility = NODE_VISIBLITY_STATUS.IDLE

func show_node(delta: float) -> void:
	if offset.x > 0:
		offset.x -= speed * delta
	else:
		node_visibility = NODE_VISIBLITY_STATUS.IDLE
