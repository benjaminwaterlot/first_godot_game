extends TileMap

# REFERENCES
var collision = preload("res://utils/collisions.gd")

func _ready():
	set_collision_layer(collision.GROUND)
	set_collision_mask(collision.UNIT_STOPPED + collision.UNIT_MOVING)
	pass
