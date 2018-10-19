# UnitManager handles the list of in-game units and send orders to them.
# CLASS
extends Node2D

# REFERENCES
onready var hud_manager = $"../HUDManager"

# FUNCTIONS
func send_move_order(destination):
	get_tree().call_group("selection", "receive_move_order", destination)
	hud_manager.display_move_GUI(destination)

func send_action_order(target):
	get_tree().call_group("selection", "receive_action_order", target)

func send_aggro_order():
	for unit in get_tree().get_nodes_in_group("units"):
		unit.receive_aggro_signal()

func register_unit(unit):
	unit.add_to_group("units")
	if unit.team == 1:
		unit.add_to_group("enemies")

func unregister_unit(dead_unit):
	if dead_unit.is_in_group("units"):
		dead_unit.remove_from_group("units")

	if dead_unit.is_in_group("selection"):
		dead_unit.remove_from_group("selection")

	for any_unit in get_tree().get_nodes_in_group("units"):
		if ("attack_target" in any_unit) and (any_unit.attack_target == dead_unit):
			any_unit.attack_target = null

	dead_unit.queue_free()