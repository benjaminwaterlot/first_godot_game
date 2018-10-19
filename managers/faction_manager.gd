# CLASS
extends Node

# REFERENCES
signal resources_updated

# STATS
export (int) var wood_amount = 150

# FUNCTIONS
func _ready():
	pass

func connect_building(building):
	building.connect("unit_creation", self, "request_unit_creation", [])

func request_unit_creation(entity, creator):
	if (wood_amount >= 40):
		make_expense(40)
		create_unit(entity, creator)

func make_expense(price):
	wood_amount -= price
	emit_signal("resources_updated")
	print("Wood remaining : ", wood_amount)

func create_unit(entity, creator):
	print("this is my created ", entity)
	print("this is my creator ", creator.name)
	var new_entity = entity.instance()
	new_entity.team = 0
	get_tree().get_root().add_child(new_entity)
	new_entity.position = creator.position