extends Node
class_name ReadyMenu

var menu: Menu
var score: int
var percentage: float

enum MENU_PERFORMANCE { TRASH, BAD, GOOD, EXCELENT }
var menu_performance: MENU_PERFORMANCE

# constructor
static func ReadyMenu(fn_menu: Menu, fn_score: int) -> ReadyMenu:
	var instance = ReadyMenu.new()
	instance.menu = fn_menu
	instance.score = fn_score
	
	instance.percentage = instance.score / \
		instance.menu.ingredients.size() * Note.SCORE_STATE.PERFECT
	
	if instance.percentage < .15:
		instance.menu_performance = MENU_PERFORMANCE.TRASH
	elif instance.percentage < .38:
		instance.menu_performance = MENU_PERFORMANCE.BAD
	elif instance.percentage < .78:
		instance.menu_performance = MENU_PERFORMANCE.GOOD
	elif instance.percentage >= .92:
		instance.menu_performance = MENU_PERFORMANCE.EXCELENT
	
	return instance
