extends VSlider
class_name MenuProgress

@export var min_max_val: Vector2
@export var duration := .3

var menu_progress := 0.0:
	get:
		return ScoreManager.Instance.current_score
var max_menu_progress := 0.0:
	get:
		return Conductor.Instance.current_menu.max_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	min_value = min_max_val.x
	max_value = min_max_val.y
	
	Conductor.Instance.track_changed.connect(track_changed)
	ScoreManager.Instance.beat_triggered.connect(update_progress)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_progress(_score := Note.SCORE_STATE.PERFECT) -> void:
	var progress = menu_progress / max_menu_progress
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "value", progress, duration)
	print("Slider Value: " + str(value))

func track_changed(menu: Menu) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "value", 0, duration)
	print("Slider Value: " + str(value))
