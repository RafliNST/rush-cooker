extends Node
class_name CustomerManager

@export var customer_scene: PackedScene
@export var spawn_points: Array[Node2D]
@export var table_points: Array[Node2D]

@export var menu_selection: Array[Menu]

@onready var new_customer_timer := $SpawnNewCustomer

func _ready() -> void:
	new_customer_timer.start()

func _on_spawn_new_customer_timeout() -> void:
	var customer = customer_scene.instantiate()
	spawn_points.pick_random().add_child(customer)
	customer.initialize(table_points.pick_random(), 
		menu_selection.pick_random())
