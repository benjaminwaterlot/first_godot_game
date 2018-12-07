# CLASS
extends Node2D

# STATS
export (int) var team
export (int) var hp = 10
var current_hp = hp

# REFERENCES
onready var buildings_manager = $"/root/World/Managers/BuildingsManager"
onready var building_hud = $"BuildingHUD"
onready var life_bar = $"BuildingHUD/LifeBar"
onready var building_gui = $"BuildingGUI"
onready var button =$"BuildingGUI/Button"
signal unit_creation(entity, creator)


# FUNCTIONS
func _ready():
	buildings_manager.register_building(self)
	button.connect("button_clicked", self, "on_button_click")
	trigger_selected(false)

func take_damage(damage):
	current_hp -= damage
	life_bar.value = current_hp
	if current_hp <= 0:
		die()

func on_button_click():
	pass

func trigger_selected(is_selected):
	if is_selected:
		building_hud.show()
		building_gui.show()
	else:
		building_hud.hide()
		building_gui.hide()

func die():
	buildings_manager.unregister_building(self)