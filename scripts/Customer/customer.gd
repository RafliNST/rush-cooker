extends Node2D
class_name Customer

signal clicked(customer: Customer)

@export var mov_speed := 300.0
@export var waiting_time := 30.0

@onready var order_icon := $OrderNotifier/OrderIcon
@onready var waiting_timer := $PatientTimer

var origin_pos := Vector2.ZERO
var seat_pos: Node2D
var menu: Menu

enum ORDER_STATE { WALKING, WAITING, SERVED, RETURN }
var order_state := ORDER_STATE.WALKING

func _process(delta: float) -> void:
	if order_state == ORDER_STATE.WALKING:
		move_to_(seat_pos.global_position, delta)
	elif order_state == ORDER_STATE.RETURN:
		move_to_(origin_pos, delta)

func initialize(seat: Node2D, func_menu: Menu) -> void:
	seat_pos = seat
	menu = func_menu
	order_icon.texture = menu.icon
	origin_pos = global_position
	
	waiting_timer.wait_time = waiting_time
	order_icon.hide()

func move_to_(target: Vector2, delta: float) -> void:
	global_position = global_position.move_toward(target, 
		mov_speed * delta)
	
	if global_position.distance_to(target) < .1:
		order_state = ORDER_STATE.WAITING
		order_icon.show()
		waiting_timer.start()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("Halo~")
		receive_order()

func receive_order() -> void:
	if not Conductor.Instance.menu_complete or \
		order_state == ORDER_STATE.RETURN:
		return
	
	if Conductor.Instance.current_menu == menu:
		order_state = ORDER_STATE.RETURN
		CustomerManager.Instance.order_complete.emit(self)

func _on_on_screen_notifier_screen_exited() -> void:
	if order_state == ORDER_STATE.RETURN:
		queue_free()
