# CLASS
extends '../unit.gd'

# REFERENCES
onready var unit_aggro = $"UnitAggro"

# STATS
export (int) var attack_damage = 1
export (float) var attack_speed = .8
export (float) var attack_range = 30

# STATE
var attack_target
var attack_cooldown = 0
var is_attacking = false

# FUNCTIONS
func _ready():
	._ready()
	unit_sprite = $"UnitSprite"

func _process(delta):
	if attack_target != null:
		var in_range = position.distance_to(attack_target.position) < attack_range
		if in_range:
			stop_moving()
			if attack_cooldown <= 0:
				attack_cooldown = attack_speed
				attack_now(attack_target)
				unit_sprite.attack()
			else:
				attack_cooldown -= delta
		else:
			is_attacking = false
			set_moving(attack_target.position)

func attack_now(target):
	target.take_damage(attack_damage)
	var is_target_on_right = target.position.x > position.x
	flip(is_target_on_right)

func receive_move_order(position):
	.receive_move_order(position)
	attack_target = null

func receive_action_order(target):
	if target.team != team:
		attack_target = target
	else:
		.receive_action_order(target)

func receive_aggro_signal():
	if attack_target != null or move_destination:
		return
	var close_units = unit_aggro.get_overlapping_bodies()
	for entity in close_units:
		if "team" in entity and entity.team != team:
			attack_target = entity