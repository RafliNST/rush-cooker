extends Control
class_name ScoreControl

@onready var score_label := $IncomeBox/ScoreLabel

var score := 0

func _ready() -> void:
	CustomerManager.Instance.order_complete.connect(order_complete)
	
func update_score(note_score: Note.SCORE_STATE) -> void:
	score_label.text = str(score)
	
func order_complete(customer: Customer) -> void:
	score += customer.menu.price
	score_label.text = str(score)
