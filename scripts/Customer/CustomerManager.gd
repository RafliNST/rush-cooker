extends Node
class_name CustomerManager

static var Instance: CustomerManager

signal order_complete(customer: Customer)

@export var elapse_time: float

@export var customer_scene: PackedScene
@export var spawn_points: Array[Node2D]

enum TABLE_AVAILABILITY { NO, YES }
@export var table_points: Array[Node2D]
@export var menu_selection: Array[Menu]

var tables_dict := { }

@onready var new_customer_timer := $SpawnNewCustomer

func _enter_tree() -> void:
	Instance = self

func _exit_tree() -> void:
	Instance = null

func _ready() -> void:
	for table in table_points:
		tables_dict[table] = TABLE_AVAILABILITY.YES
		
	new_customer_timer.wait_time = elapse_time
	new_customer_timer.start()

func get_available_tables() -> Array[Node2D]:
	var tables: Array[Node2D]
	for table in table_points:
		if tables_dict[table] == TABLE_AVAILABILITY.YES:
			tables.append(table)
		
	return tables
	
func set_table(point: Node2D, status: TABLE_AVAILABILITY) -> void:
	if tables_dict.has(point):
		tables_dict[point] = status
	
func _on_spawn_new_customer_timeout() -> void:
	var table = get_available_tables()
	var menu = menu_selection.pick_random()
	
	if table.size() <= 0:
		return
	
	table = table.pick_random()
	set_table(table, TABLE_AVAILABILITY.NO)
	
	var customer = customer_scene.instantiate()
	spawn_points.pick_random().add_child(customer)
	customer.initialize(table,menu)

func _on_order_complete(customer: Customer) -> void:
	set_table(customer.seat_pos, TABLE_AVAILABILITY.YES)
