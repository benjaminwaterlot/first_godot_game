# CLASS
extends Node2D

# STATE
var selecting = false
var selecting_start

# FUNCTIONS
func _process(delta):
	if selecting:
		update()

func _draw():
	if selecting:
		var mouse_position = get_global_mouse_position()
		draw_polygon([
				selecting_start,
				Vector2(selecting_start.x, mouse_position.y),
				mouse_position,
				Vector2(mouse_position.x, selecting_start.y)
				],
				[Color(.5, .6, .2, 0.5)])

func stop_selecting():
	selecting = false
	selecting_start = null
	update()

func start_selecting(start_position):
	selecting = true
	selecting_start = start_position