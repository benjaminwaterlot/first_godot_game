extends Button

var bakery = preload("res://scenes/building/bakery/Bakery.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and event.pressed:
		print("BONJOUR")
		var new_bakery = bakery.instance()
		get_tree().get_root().add_child(new_bakery)
		var target_position = get_node("./../../../Citizen").position
		new_bakery.position = target_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
