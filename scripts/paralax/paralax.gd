extends Camera2D

@export var speed = 5.0
@export var target_node: Node2D # Optional: Attach a player node

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	
	if target_node:
		# Option A: Move towards a point between player and mouse
		var target = (target_node.global_position + mouse_pos) / 2
		global_position = Vector2(global_position.lerp(target, speed * delta).x, 0)
	else:
		# Option B: Move directly to mouse position
		global_position = Vector2(global_position.lerp(mouse_pos, speed * delta).x, 0)
