extends Panel
class_name DayResultPanel

static var Instance: DayResultPanel

 #region stat to track:
#Customer Served
@onready var customer_val := $Container/BoxContainer/LeftBoxes/CustomerHandled/StatValue
#Unhandled Customer
@onready var unhandled_val := $Container/BoxContainer/LeftBoxes/UnhandledCustomer/StatValue
#Best Combo
@onready var best_combo_val := $Container/BoxContainer/RightBoxes/BestCombo/StatValue
#Perfect Hits
@onready var perfect_hits_val := $Container/BoxContainer/RightBoxes/PerfectHits/StatValue
#Income
@onready var incomes_val := $Container/IncomePanel/StatValue
#endregion

@export var ending_dialogue_path: String

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	hide()
	set_process(false)

func change_stat() -> void:
	#handled customer
	customer_val.text = str(CustomerManager.Instance.customer_served)
	StateMachine.save_file.handled_customer = CustomerManager.Instance.customer_served
	#unhandled customer
	unhandled_val.text = str(CustomerManager.Instance.unhandled_customer)
	StateMachine.save_file.unhandled_customer = CustomerManager.Instance.unhandled_customer
	#best combo
	best_combo_val.text = str(ScoreManager.Instance.best_combo) + "x"
	StateMachine.save_file.best_combo = ScoreManager.Instance.best_combo
	#perfect hit
	perfect_hits_val.text = str(ScoreManager.Instance.perfect_hits) + "x"
	StateMachine.save_file.perfect_hit = ScoreManager.Instance.perfect_hits

func _on_day_cycle_day_finished() -> void:
	set_process(true)
	show()
	
	change_stat()

func _on_next_day_button_pressed() -> void:
	get_tree().change_scene_to_file(ending_dialogue_path)
