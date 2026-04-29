extends CanvasLayer

@onready var selector_container := $MenuControl/VBoxContainer

@export var menu_selector : PackedScene
@export var menus : Array[Menu]

@export var x_offset := 100

var _tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Paralax.Instance != null:
		Paralax.Instance.camera_move.connect(on_camera_focus)
		Paralax.Instance.camera_to_center.connect(on_camera_unfocus)
	
	for menu in menus:
		var selector = menu_selector.instantiate()
		selector_container.add_child(selector)
		selector.initialize(menu)

func on_camera_focus() -> void:
	if _tween and _tween.is_running():
		_tween.kill()
	
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_CIRC)
	_tween.tween_property(self, "offset:x", x_offset, .71)

func on_camera_unfocus() -> void:
	if _tween and _tween.is_running():
		_tween.kill()
	
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_CIRC)
	_tween.tween_property(self, "offset:x", 0, .57)

func _on_day_cycle_day_finished() -> void:
	on_camera_unfocus()
