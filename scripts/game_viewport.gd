extends SubViewport

@export var base_length := 852
@export var extended_length := 1152

var _tween: Tween

func _ready() -> void:
	if Paralax.Instance != null:
		Paralax.Instance.camera_move.connect(on_camera_unfocus)
		Paralax.Instance.camera_to_center.connect(on_camera_focus)

func on_camera_focus() -> void:
	if _tween and _tween.is_running():
		_tween.kill()
	
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_QUINT)
	_tween.tween_property(self, "size:x", base_length, .47)
	
func on_camera_unfocus() -> void:
	if _tween and _tween.is_running():
		_tween.kill()
		
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN)
	_tween.set_trans(Tween.TRANS_BACK)
	_tween.tween_property(self, "size:x", extended_length, .46)
