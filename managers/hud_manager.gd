# CLASS
extends Node2D

# STATE
var selecting : bool = false
var selecting_start : Vector2
var show_move_GUI : bool = false
var move_GUI_position : Vector2

# FUNCTIONS

func _process(delta):
	if selecting:
		update()

func _draw():
	if selecting:
		var mouse_position : Vector2 = get_global_mouse_position()
		var coordinates : PoolVector2Array = PoolVector2Array([
				selecting_start,
				Vector2(selecting_start.x, mouse_position.y),
				mouse_position,
				Vector2(mouse_position.x, selecting_start.y)
				])
		var colors : PoolColorArray = ([Color(.5, .6, .2, 0.5)] as PoolColorArray)
		draw_polygon(coordinates, colors)
	if show_move_GUI:
		draw_move_GUI(move_GUI_position);

func 	display_move_GUI(position):
	move_GUI_position = position
	show_move_GUI = true
	update()

func draw_move_GUI(position):
	var space_state = get_world_2d().direct_space_state
	var start = Vector2(position.x, 0)
	var end = Vector2(position.x, 10000)
	var entity = space_state.intersect_ray(start, end, [], pow(2, 10) + pow(2, 20))
	if entity and "collider" in entity:
		draw_line(Vector2(entity.position.x - 10, entity.position.y), Vector2(entity.position.x + 10, entity.position.y), Color("#B71E3F"), 10, true)

func stop_selecting():
	selecting = false
	selecting_start = Vector2()
	update()

func start_selecting(start_position):
	selecting = true
	selecting_start = start_position