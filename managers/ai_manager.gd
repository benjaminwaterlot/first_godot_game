# Managers/AIManager trigger regular AI functions and send resulting orders to UnitManager.
# CLASS
extends Node2D

# STATE
var aggro_rate = .8
var aggro_countdown = aggro_rate

# REFERENCES
onready var units_manager = $"../UnitsManager"

# FUNCTIONS
func _process(delta):
	aggro_countdown -= delta

	if aggro_countdown <= 0:
		aggro_countdown = aggro_rate
		trigger_aggro()

func trigger_aggro():
	units_manager.send_aggro_order()
	pass