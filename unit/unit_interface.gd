extends Node2D

onready var unit = $"../"
onready var unit_manager = $"/root/World/UnitsManager"
onready var unit_movement = $"../UnitMovement"
onready var unit_hud = $"../UnitHUD"
onready var life_bar = $"../UnitHUD/LifeBar"

func _ready():
	unit_manager.register_unit(self)

func receive_move_order(position):
	unit_movement.move_destination = position
	print("RIGHTCLICK")

func trigger_selected(is_selected):
	if is_selected:
		unit_hud.show()
	else:
		unit_hud.hide()

func take_damage(damage):
	unit.current_hp -= damage
	life_bar.value = unit.current_hp
	print("i have x hp left : ", unit.current_hp)