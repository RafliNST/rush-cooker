extends Node2D
class_name Customer

@export var mov_speed := 300.0
@export var waiting_time := 30.0
@export var angry_change := .35
@export var eat_time := 7.0

@onready var order_icon := $OrderNotifier/OrderIcon
@onready var waiting_timer := $PatientTimer
@onready var customer_sprite := $CustomerSprite

var origin_pos := Vector2.ZERO
var seat_pos: Node2D
var menu: Menu
var is_menu_served := false
var seat_at_right:= false

enum ORDER_STATE { WALKING, WAITING, SERVED, RETURN }
var order_state := ORDER_STATE.WALKING

func _process(delta: float) -> void:
	if order_state == ORDER_STATE.WALKING:
		move_to_(seat_pos.global_position, delta)
	elif order_state == ORDER_STATE.RETURN:
		move_to_(origin_pos, delta)

func initialize(seat: Node2D, func_menu: Menu, func_seat: bool) -> void:
	seat_pos = seat
	menu = func_menu
	order_icon.texture = menu.icon
	origin_pos = global_position
	seat_at_right = func_seat
	
	waiting_timer.wait_time = waiting_time
	order_icon.hide()
	
	if origin_pos.x > 0:
		customer_sprite.flip_h = true
	else:
		customer_sprite.flip_h = false

func move_to_(target: Vector2, delta: float) -> void:
	global_position = global_position.move_toward(target, 
		mov_speed * delta)
	
	if global_position.distance_to(target) < .1:
		if order_state == ORDER_STATE.RETURN:
			queue_free()
		
		order_state = ORDER_STATE.WAITING
		order_icon.show()
		waiting_timer.start()
		
		customer_sprite.play("idle")
		if seat_at_right:
			customer_sprite.flip_h = true
		else:
			customer_sprite.flip_h = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		receive_order()

func receive_order() -> void:
	if not NoteSpawner.Instance.menu_ready or \
		order_state != ORDER_STATE.WAITING:
		return
	
	if Conductor.Instance.current_menu == menu:
		customer_sprite.play("eat")
		
		is_menu_served = true
		order_state = ORDER_STATE.SERVED
		
		waiting_timer.wait_time = eat_time
		waiting_timer.start()
		
		order_icon.hide()

func _on_patient_timer_timeout() -> void:
	order_state = ORDER_STATE.RETURN
	
	order_icon.hide()
	customer_sprite.play("walk")
	if origin_pos.x < 0:
		customer_sprite.flip_h = true
	else:
		customer_sprite.flip_h = false
	
	if is_menu_served or randf() > angry_change:
		CustomerManager.Instance.order_complete.emit(self)
