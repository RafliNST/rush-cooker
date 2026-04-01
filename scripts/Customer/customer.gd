extends Node2D
class_name Customer

@export var mov_speed := 300.0

@onready var order_icon := $OrderNotifier/OrderIcon

var is_reach := false

var origin_pos := Vector2.ZERO
var seat_pos: Node2D
var menu: Menu
var is_reached_seat := false

var is_delivered := false

func _process(delta: float) -> void:
	move_to_(seat_pos.global_position, delta)

func initialize(seat: Node2D, menu: Menu) -> void:
	seat_pos = seat
	order_icon.texture = menu.icon
	
	order_icon.hide()
	
func move_to_(target: Vector2, delta: float) -> void:
	if is_reach:
		return
		
	global_position = global_position.move_toward(seat_pos.global_position, 
		mov_speed * delta)
	
	if global_position.distance_to(target) < .1:
		is_reach = true
		order_icon.show()
