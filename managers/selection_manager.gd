extends Node2D

func clear_selection():
	for unit in get_tree().get_nodes_in_group("selection"):
		unit.remove_from_group("selection")
		unit.trigger_selected(false)

func add_to_selection(entity):
	entity.add_to_group("selection")
	entity.trigger_selected(true)

func _ready():
	pass
