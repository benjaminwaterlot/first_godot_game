extends Node

func _input(event):
	if event.is_action_pressed("mouse_right_click"):
		send_order(get_global_mouse_position())

func send_order(destination):
	get_tree().call_group("selection", "receive_move_order", destination)