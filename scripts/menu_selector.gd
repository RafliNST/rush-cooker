extends Control

@onready var activator := $ActivatorSelection

var menu : Menu

func initialize(menu: Menu):
	self.menu = menu
	
	activator.text = menu.name
	activator.icon = menu.icon

func _on_activator_selection_pressed() -> void:
	if StateMachine.current_state is not RhythmState:
		return
	Conductor.Instance.track_changed.emit(menu)
