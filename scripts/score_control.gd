extends Control
class_name ScoreControl

@onready var score_label := $ScoreBox/ScoreLabel

var score := 0

var menu_progress := 0:
	get:
		return ScoreManager.Instance.current_score
var max_menu_progress := 0:
	get:
		return Conductor.Instance.current_menu.max_score

func _ready() -> void:
	CustomerManager.Instance.order_complete.connect(order_complete)


func order_complete(customer: Customer) -> void:
	if not customer.is_menu_served:
		return
	
	var menu_score = customer.menu.price * \
		PlayerTenant.Instance.menu_performane
	score += menu_score
	score += menu_score * .5 if StateMachine.save_file.is_combo_high \
		else 0
	score_label.text = str(score)
	
	DayResultPanel.Instance.incomes_val.text = "Rp" + str(score)
	StateMachine.save_file.incomes += score
