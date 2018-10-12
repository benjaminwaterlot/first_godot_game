extends Node

onready var unit_movement = $"../UnitMovement"
onready var unit = $"../"

func _ready():
	add_to_group("selection")

func receive_move_order(position):
	unit_movement.move_destination = position
	if unit.name == "Enemy":
		print("I am ", unit.name," now at position ", unit.position.x, " and shall move at position ", position.x)

func remove_from_selection():
	remove_from_group("selection")