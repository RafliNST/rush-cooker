extends Resource
class_name SaveFile

var handled_customer: int
var unhandled_customer: int
var best_combo: int
var perfect_hit: int
var incomes: int

var unhandled_customer_too_many := false
var is_win := false
var is_bankrupt := false
var is_combo_high := false
var is_handled_many := false

func reset_stat() -> void:
	unhandled_customer_too_many = false
	is_win = false
	is_bankrupt = false
	is_combo_high = false
	is_handled_many = false
	
	handled_customer = 0
	unhandled_customer = 0
	best_combo = 0
	perfect_hit = 0
	incomes = 0
	
