# CLASS
extends Node2D

# STATS
var units = []

# FUNCTIONS
func send_move_order(destination):
	get_tree().call_group("selection", "receive_move_order", destination)

func send_attack_order(target):
	get_tree().call_group("selection", "receive_attack_order", target)

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