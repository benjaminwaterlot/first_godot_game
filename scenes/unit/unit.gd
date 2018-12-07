# Unit is the hub of any unit. Handles stats, processing and interface with Managers/UnitsManager.
# CLASS
extends KinematicBody2D

# REFERENCES
var collision = preload("res://utils/collisions.gd")
onready var units_manager = $"/root/World/Managers/UnitsManager"
onready var unit_hud = $"UnitHUD"
onready var life_bar = $"UnitHUD/LifeBar"
onready var unit_sprite = $"UnitSprite"

# STATS
var GRAVITY = 2200
export (int) var team = 0
export (int) var move_speed = 200
export (int) var hp = 10

# STATE
var current_hp = hp
var velocity = Vector2()
var move_destination

# FUNCTIONS
	# INTERFACE
func receive_move_order(position):
	set_moving(position)

func receive_action_order(target):
	receive_move_order(target.position)

func trigger_selected(is_selected):
	if is_selected:
		unit_hud.show()
	else:
		unit_hud.hide()

func move_to(destination):
	move_and_slide(destination, Vector2(0, -1))

func receive_aggro_signal():
	pass

		# COMPUTING
func _ready():
	units_manager.register_unit(self)
	unit_hud.hide()
	set_collision_layer(collision.UNIT_STOPPED)
	set_collision_mask(collision.UNIT_STOPPED)

func _physics_process(delta):
	velocity = compute_gravity(velocity, delta)
	velocity = compute_movement(velocity)
	move_to(velocity)

		# REACTIONS
func take_damage(damage):
	current_hp -= damage
	life_bar.value = current_hp
	if current_hp <= 0:
		die()

func die():
	units_manager.unregister_unit(self)

		# UTILS
func set_moving(destination):
	set_collision_layer(collision.UNIT_MOVING)
	set_collision_mask(collision.UNIT_MOVING)
	move_destination = destination

func stop_moving():
	velocity.x = 0
	set_collision_layer(collision.UNIT_STOPPED)
	set_collision_mask(collision.UNIT_STOPPED)
	move_destination = null

func compute_gravity(velocity, delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta
	return velocity

func compute_movement(velocity):
	velocity.x = 0

	if move_destination:
		var remaining_distance = move_destination.x - position.x
		var is_facing_right = remaining_distance > 0
		var is_arrived = abs(remaining_distance) < 5
		if is_arrived:
			stop_moving()
			unit_sprite.play("idle")
		else:
			velocity.x = move_speed if is_facing_right else - move_speed
			unit_sprite.play("run")
			flip(is_facing_right)
	return velocity

func flip(is_facing_right):
	if (is_facing_right == unit_sprite.flip_h):
		unit_sprite.flip_h = !unit_sprite.flip_h
	return velocity