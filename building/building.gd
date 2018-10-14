# CLASS
extends Node2D

# STATS
export (int) var team = 5
export (int) var hp = 10
var current_hp = hp

# REFERENCES
onready var buildings_manager = $"/root/World/Managers/BuildingsManager"
onready var faction_manager = $"/root/World/Managers/FactionManager"
onready var building_hud = $"BuildingHUD"
onready var life_bar = $"BuildingHUD/LifeBar"
onready var building_gui = $"BuildingGUI"
var warrior = preload("res://unit/warrior/enemy/enemy.tscn")

# FUNCTIONS
func _ready():
	buildings_manager.register_building(self)

func take_damage(damage):
	current_hp -= damage
	life_bar.value = current_hp
	if current_hp <= 0:
		die()

func trigger_selected(is_selected):
	if is_selected:
		building_hud.show()
		building_gui.show()
	else:
		building_hud.hide()
		building_gui.hide()

func die():
	buildings_manager.unregister_building(self)

func request_soldier():
	faction_manager.request_creation(self, warrior)