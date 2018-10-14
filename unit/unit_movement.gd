# UnitMovement handles pathfinding and actual unit movement.
# CLASS
extends Node2D

# REFERENCES
onready var unit = $"../"
onready var warrior_sprite = $"../WarriorSprite"
var velocity = Vector2()
var move_destination

# STATS
export (int) var GRAVITY = 2200

# FUNCTIONS
func _physics_process(delta):
	velocity = compute_gravity(velocity, delta)
	velocity = compute_movement(velocity)
	move_to(velocity)

func start_moving(destination):
	unit.set_collision_layer(pow(2, 1))
	unit.set_collision_mask(pow(2, 10))
	move_destination = destination

func stop_moving():
	unit.set_collision_layer(pow(2, 0))
	unit.set_collision_mask(pow(2, 0) + pow(2, 10))
	move_destination = null

func compute_gravity(velocity, delta):
	if unit.is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta

	return velocity

func compute_movement(velocity):
	velocity.x = 0

	if move_destination:
		var remaining_distance = move_destination.x - unit.position.x
		var is_arrived = abs(remaining_distance) < 5

		if is_arrived:
			stop_moving()
			velocity.x = 0
			warrior_sprite.play("idle")

		else:
			var is_going_right = remaining_distance > 0
			velocity.x = unit.move_speed if is_going_right else - unit.move_speed
			warrior_sprite.play("running")
			if is_going_right == warrior_sprite.flip_h :
				warrior_sprite.flip_h = !warrior_sprite.flip_h

	return velocity

func move_to(destination):
	unit.move_and_slide(destination, Vector2(0, -1))