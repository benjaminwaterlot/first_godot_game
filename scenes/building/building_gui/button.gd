# CLASS
extends Button

# REFERENCES
onready var building = $"../../"
signal button_clicked

# FUNCTIONS
func _gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and event.pressed:
		emit_signal("button_clicked")
		accept_event()
