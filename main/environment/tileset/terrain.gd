extends TileMap

func _ready():
	set_collision_layer_bit(10, true)
	set_collision_mask_bit(0, true)
	set_collision_mask_bit(1, true)
	pass
