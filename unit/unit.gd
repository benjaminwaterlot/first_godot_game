# CLASS
extends KinematicBody2D

# REFERENCES
onready var units_manager = $"/root/World/UnitsManager"
onready var unit_movement = $"UnitMovement"
onready var unit_sprite = $"UnitSprite"
onready var unit_hud = $"UnitHUD"
onready var life_bar = $"UnitHUD/LifeBar"

# STATS
export (bool) var ally
export (int) var move_speed = 150
export (int) var hp = 10
export (int) var attack_damage = 1
export (float) var attack_speed = 1
export (float) var attack_range = 10

# STATE
var current_hp = hp
var attack_target
var attack_cooldown = 0

# FUNCTIONS
func _ready():
	units_manager.register_unit(self)
	unit_hud.hide()

func _process(delta):
	if attack_target:
		var in_range = self.position.distance_to(attack_target.position) < attack_range
		if in_range:
			unit_movement.move_destination = null
			if attack_cooldown <= 0:
				attack_now(attack_target)
				unit_sprite.attack()
				attack_cooldown = attack_speed
			else:
				attack_cooldown -= delta
		else:
			unit_movement.move_destination = attack_target.position

func attack_now(target):
	target.take_damage(attack_damage)

func receive_move_order(position):
	unit_movement.move_destination = position
	attack_target = null

func receive_attack_order(target):
	attack_target = target
	print("I received an attack order for ", target)

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
	self.queue_free()