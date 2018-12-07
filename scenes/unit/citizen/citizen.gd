# CLASS
extends '../unit.gd'

# REFERENCES

# STATS
var gather_speed = .5

# STATE

# FUNCTIONS
func _ready():
	unit_sprite = $"UnitSprite"
	._ready()

func receive_action_order(target):
	receive_move_order(target.position)

func receive_aggro_signal():
	pass