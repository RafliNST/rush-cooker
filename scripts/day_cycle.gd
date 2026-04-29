extends Node2D
class_name DayCycle

static var Instance: DayCycle

signal day_finished

@onready var day_timer := $DayTimer

@export var minutes_to_cycle := 3.0

var cycle_complete := false

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	cycle_complete = false
	day_timer.wait_time = minutes_to_cycle * 60
	day_timer.start()

func _on_day_timer_timeout() -> void:
	cycle_complete = true
