# CLASS
extends Button

# REFERENCES
onready var building = $"../../"

# FUNCTIONS
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		building.request_soldier()
		accept_event()