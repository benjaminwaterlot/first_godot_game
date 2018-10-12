# CLASS
extends KinematicBody2D

# STATS
export (bool) var ally
export (int) var move_speed = 150
export (int) var hp = 10

# FUNCTIONS
func take_damage(damage):
	hp -= damage