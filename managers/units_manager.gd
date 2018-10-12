extends Node

var units = []

func send_order(destination):
	get_tree().call_group("selection", "receive_move_order", destination)

func clear_selection():
	for unit in get_tree().get_nodes_in_group("selection"):
		unit.remove_from_group("selection")
		unit.trigger_selected(false)

func add_to_selection(unit):
	unit.add_to_group("selection")
	unit.trigger_selected(true)

func register_unit(unit):
	units.push_front(unit)
	unit.add_to_group("units")

func destroy_unit(unit):
	units.erase(unit)
	unit.remove_from_group("units")
	unit.remove_from_group("selection")