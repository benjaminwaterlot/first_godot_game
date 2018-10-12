extends Node

var selection_start
onready var units_manager = $"../UnitsManager"
onready var hud_manager = $"../HUDManager"

func _input(event):
	var mouse_position = get_global_mouse_position()

	if event.is_action_pressed("mouse_right_click"):
		units_manager.send_order(mouse_position)

	if event.is_action_pressed("mouse_left_click"):
		selection_start = mouse_position
		hud_manager.start_selecting(selection_start)

	if event.is_action_released("mouse_left_click"):
		units_manager.clear_selection()
		hud_manager.stop_selecting()

		if mouse_position.distance_squared_to(selection_start) > 100:
			select_in_rectangle(selection_start, mouse_position)
		else:
			select_pointed_entity(mouse_position)

func select_in_rectangle(start, end):
	var smaller_x = min(start.x, end.x)
	var higher_x = max(start.x, end.x)
	var smaller_y = min(start.y, end.y)
	var higher_y = max(start.y, end.y)

	for unit in get_tree().get_nodes_in_group("units"):
		if smaller_x < unit.global_position.x and unit.global_position.x < higher_x:
			if smaller_y < unit.global_position.y and unit.global_position.y < higher_y:
				units_manager.add_to_selection(unit)

func select_pointed_entity(position):
	var space_state = get_world_2d().direct_space_state
	var end = Vector2(position.x + 1, position.y)
	var collision = space_state.intersect_ray(position, end)
	if collision and collision.collider.has_node("UnitInterface"):
		units_manager.add_to_selection(collision.collider.get_node("UnitInterface"))