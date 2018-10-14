# CLASS
extends Node2D

# REFERENCES
onready var units_manager = $"../UnitsManager"
onready var selection_manager = $"../SelectionManager"
onready var hud_manager = $"../HUDManager"

# STATE
var selection_start

# FUNCTIONS
func _input(event):
	var mouse_position = get_global_mouse_position()

	if event.is_action_pressed("mouse_right_click"):
		var unit_touched = return_pointed_entity(mouse_position)

		if unit_touched and "team" in unit_touched:
			units_manager.send_action_order(unit_touched)
		else:
			units_manager.send_move_order(mouse_position)

	if event.is_action_pressed("mouse_left_click"):
		selection_start = mouse_position
		hud_manager.start_selecting(selection_start)

	if event.is_action_released("mouse_left_click"):
		selection_manager.clear_selection()
		hud_manager.stop_selecting()

		if mouse_position.distance_to(selection_start) > 100:
			select_in_rectangle(selection_start, mouse_position)
		else:
			var selected = return_pointed_entity(mouse_position)
			if selected:
				selection_manager.add_to_selection(selected)

func select_in_rectangle(start, end):
	var smaller_x = min(start.x, end.x)
	var higher_x = max(start.x, end.x)
	var smaller_y = min(start.y, end.y)
	var higher_y = max(start.y, end.y)

	for entity in ( get_tree().get_nodes_in_group("units") + get_tree().get_nodes_in_group("buildings") ):
		if smaller_x < entity.global_position.x and entity.global_position.x < higher_x:
			if smaller_y < entity.global_position.y and entity.global_position.y < higher_y:
				selection_manager.add_to_selection(entity)

func return_pointed_entity(position):
	var space_state = get_world_2d().direct_space_state
	var start = Vector2(position.x - 15, position.y - 10)
	var end = Vector2(position.x + 15, position.y + 10)
	var entity = space_state.intersect_ray(start, end, [], pow(2, 0) + pow(2, 1) + pow(2, 9))
	print(entity)
	if entity and "team" in entity.collider:
		return entity.collider