# CLASS
extends Node

# REFERENCES
signal resources_updated

# STATS
export (int) var wood_amount = 150

# FUNCTIONS
func _ready():
	pass

func request_creation(creator, entity):
	if (wood_amount >= 40):
		make_expense(40)
		create_unit(creator, entity)

func make_expense(price):
	wood_amount -= price
	emit_signal("resources_updated")
	print("Wood remaining : ", wood_amount)

func create_unit(creator, entity):
	var new_entity = entity.instance()
	get_tree().get_root().add_child(new_entity)
	new_entity.position = creator.position