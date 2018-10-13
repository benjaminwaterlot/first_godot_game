extends Node2D

onready var unit = $"../"
onready var unit_movement = $"../UnitMovement"
onready var unit_hud = $"../UnitHUD"
onready var life_bar = $"../UnitHUD/LifeBar"

func receive_move_order(position):
	unit_movement.move_destination = position
	print("RIGHTCLICK")

func receive_attack_order(target):
	unit.attack_target = target

func trigger_selected(is_selected):
	if is_selected:
		unit_hud.show()
	else:
		unit_hud.hide()

func take_damage(damage):
	unit.current_hp -= damage
	life_bar.value = unit.current_hp