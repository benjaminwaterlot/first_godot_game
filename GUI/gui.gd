# CLASS
extends Node2D

# REFERENCES
onready var wood_gui = $"Resources/WoodAmount"
onready var faction_manager = $"/root/World/Managers/FactionManager"

# STATS

# FUNCTIONS
func _ready():
	get_node("/root/World/Managers/FactionManager").connect("resources_updated", self, "update_resources_display")
	update_resources_display()

func receive_resource(resource, amount):
	if resource == "wood":
		faction_manager.wood_amount += amount
		wood_gui.text = faction_manager.wood_amount

func update_resources_display():
		wood_gui.text = str(faction_manager.wood_amount)
