extends Control
class_name ScoreControl

@onready var score_label := $IncomeBox/ScoreLabel

var score := 0

func _ready() -> void:
	CustomerManager.Instance.order_complete.connect(order_complete)
	
func update_score(note_score: Note.SCORE_STATE) -> void:
	score_label.text = str(score)
	
func order_complete(customer: Customer) -> void:
	var menu_score = customer.menu.price * \
		PlayerTenant.Instance.menu_performane
	print("Menu Skor: " + str(menu_score))
	print("Tenant: " + str(PlayerTenant.Instance.menu_performane))
	score += menu_score
	score_label.text = str(score)
