extends Node2D

func _ready():
	pass

func register_building(building):
	building.add_to_group("buildings")
	if building.team == 1:
		print("this is an enemy")
		building.add_to_group("enemies")

func unregister_building(dead_building):
	if dead_building.is_in_group("buildings"):
		dead_building.remove_from_group("buildings")

	if dead_building.is_in_group("selection"):
		dead_building.remove_from_group("selection")

	for any_unit in get_tree().get_nodes_in_group("units"):
		if any_unit.attack_target == dead_building:
			any_unit.attack_target = null

	dead_building.queue_free()