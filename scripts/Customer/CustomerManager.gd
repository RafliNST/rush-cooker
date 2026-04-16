extends Node
class_name CustomerManager

static var Instance: CustomerManager

signal order_complete(customer: Customer)

@export var elapse_time: float

@export var customer_scene: PackedScene
@export var spawn_points: Array[Node2D]

enum TABLE_AVAILABILITY { NO, YES }
@export var table_points: Array[Table]
@export var menu_selection: Array[Menu]

var seat_points: Array[Node2D]
var seats_dict := { }

@onready var new_customer_timer := $SpawnNewCustomer

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	for i in range(0,table_points.size()):
		seat_points.append(table_points[i].left_seat)
		seat_points.append(table_points[i].right_seat)
		
	for seat in seat_points:
		seats_dict[seat] = TABLE_AVAILABILITY.YES
		
	new_customer_timer.wait_time = elapse_time
	new_customer_timer.start()

func get_available_seats() -> Array[Node2D]:
	var seats: Array[Node2D]
	for seat in seat_points:
		if seats_dict[seat] == TABLE_AVAILABILITY.YES:
			seats.append(seat)
		
	return seats
	
func set_seat(point: Node2D, status: TABLE_AVAILABILITY) -> void:
	if seats_dict.has(point):
		seats_dict[point] = status
	
func _on_spawn_new_customer_timeout() -> void:
	var seat = get_available_seats()
	var menu = menu_selection.pick_random()
	
	if seat.size() <= 0:
		return
	
	seat = seat.pick_random()
	set_seat(seat, TABLE_AVAILABILITY.NO)
	
	var customer = customer_scene.instantiate()
	spawn_points.pick_random().add_child(customer)
	customer.initialize(seat,menu)

func _on_order_complete(customer: Customer) -> void:
	set_seat(customer.seat_pos, TABLE_AVAILABILITY.YES)
