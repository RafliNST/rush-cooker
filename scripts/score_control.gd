extends Control
class_name ScoreControl

@onready var score_label := $ScoreBox/ScoreLabel
@onready var progress_label := $ScoreBox/MenuProgressLabel/ProgressLabel

var score := 0

var menu_progress := 0:
	get:
		return ScoreManager.Instance.current_score
var max_menu_progress := 0:
	get:
		return Conductor.Instance.current_menu.max_score

func _ready() -> void:
	CustomerManager.Instance.order_complete.connect(order_complete)
	ScoreManager.Instance.beat_triggered.connect(update_progress)
	
	progress_label.text = "0/0"
	
func update_score(note_score: Note.SCORE_STATE) -> void:
	score_label.text = str(score)
	
func order_complete(customer: Customer) -> void:
	var menu_score = customer.menu.price * \
		PlayerTenant.Instance.menu_performane
	score += menu_score
	score_label.text = str(score)

func update_progress(_score := Note.SCORE_STATE.PERFECT) -> void:
	progress_label.text = str(menu_progress) + "/" + str(max_menu_progress)

func _on_conductor_track_changed(menu: Menu) -> void:
	progress_label.text = str(0) + "/" + str(max_menu_progress)
