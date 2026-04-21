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

@export var save_file: SaveFile

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	hide()
	set_process(false)

func change_stat() -> void:
	customer_val.text = str(CustomerManager.Instance.customer_served)
	save_file.last_handled_customer = CustomerManager.Instance.customer_served
	
	unhandled_val.text = str(CustomerManager.Instance.unhandled_customer)
	save_file.last_unhandled_customer = CustomerManager.Instance.unhandled_customer
	
	best_combo_val.text = str(ScoreManager.Instance.best_combo) + "x"
	save_file.last_best_combo = ScoreManager.Instance.best_combo
	
	perfect_hits_val.text = str(ScoreManager.Instance.perfect_hits) + "x"
	save_file.last_perfect_hit = ScoreManager.Instance.perfect_hits

func _on_day_cycle_day_finished() -> void:
	set_process(true)
	show()
	
	change_stat()

func _on_next_day_button_pressed() -> void:
	get_tree().reload_current_scene()
