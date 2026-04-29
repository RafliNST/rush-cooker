extends CanvasLayer

@onready var resolution_option := $"background/container/resolution-label/OptionButton"

@export var screens_size: Array[Vector2i]

func _ready() -> void:
	SettingsLayer.hide()
	load_resolution()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		SettingsLayer.visible = not SettingsLayer.visible

func load_resolution() -> void:
	resolution_option.clear()
	for screen in screens_size:
		resolution_option. \
			add_item(str(screen.x) + "x" + str(screen.y))

func _on_closebutton_pressed() -> void:
	SettingsLayer.hide()

func _on_option_button_item_selected(index: int) -> void:
	var screen = resolution_option.get_item_text(index) \
		.split("x")
	
	DisplayServer.window_set_size(
		Vector2i(screen[0].to_int(), screen[1].to_int())
	)
	
	_center_window()

func _center_window() -> void:
	var screen := DisplayServer.screen_get_size()
	var win := DisplayServer.window_get_size()
	DisplayServer.window_set_position(Vector2i(
		(screen.x - win.x) / 2,
		(screen.y - win.y) / 2
	))
