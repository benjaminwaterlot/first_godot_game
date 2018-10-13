# Unit is the hub of any unit. Handles stats, processing and interface with Managers/UnitsManager.
# CLASS
extends KinematicBody2D

# REFERENCES
onready var units_manager = $"/root/World/Managers/UnitsManager"
onready var unit_movement = $"UnitMovement"
onready var unit_sprite = $"UnitSprite"
onready var unit_hud = $"UnitHUD"
onready var unit_aggro = $"UnitAggro"
onready var life_bar = $"UnitHUD/LifeBar"

# STATS
export (int) var team
export (int) var move_speed
export (int) var hp = 10
export (int) var attack_damage = 1
export (float) var attack_speed = 1
export (float) var attack_range = 30

# STATE
var current_hp = hp
var attack_target
var attack_cooldown = 0
var is_attacking = false

# FUNCTIONS
func _ready():
	units_manager.register_unit(self)
	unit_hud.hide()
	set_collision_layer(pow(2, 0))
	set_collision_mask(pow(2, 0))

func _process(delta):
	if attack_target != null:
		var in_range = position.distance_to(attack_target.position) < attack_range
		if in_range:
			unit_movement.stop_moving()
			if attack_cooldown <= 0:
				attack_cooldown = attack_speed
				attack_now(attack_target)
				unit_sprite.attack()
			else:
				attack_cooldown -= delta
		else:
			is_attacking = false
			unit_movement.start_moving(attack_target.position)

func attack_now(target):
	target.take_damage(attack_damage)
	set_collision_layer(pow(2, 1))
	set_collision_mask(pow(2, 10))

func receive_move_order(position):
	unit_movement.start_moving(position)
	attack_target = null

func receive_action_order(target):
	if target.team != team:
		attack_target = target
	else:
		receive_move_order(target.position)

func receive_aggro_order():
	if attack_target != null or unit_movement.move_destination:
		return
	var close_units = unit_aggro.get_overlapping_bodies()
	for entity in close_units:
		if "team" in entity and entity.team != team:
			attack_target = entity

func trigger_selected(is_selected):
	if is_selected:
		unit_hud.show()
	else:
		unit_hud.hide()

func take_damage(damage):
	current_hp -= damage
	life_bar.value = current_hp
	if current_hp <= 0:
		die()

func die():
	units_manager.unregister_unit(self)