# CLASS
extends "../building.gd"

# REFERENCES
var citizen = preload("res://scenes/unit/citizen/Citizen.tscn")

# FUNCTIONS
func on_button_click():
	emit_signal("unit_creation", citizen, self)