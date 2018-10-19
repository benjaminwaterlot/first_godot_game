# CLASS
extends "../building.gd"

# REFERENCES
var citizen = preload("res://unit/citizen/Citizen.tscn")

# FUNCTIONS
func on_button_click():
	print("YOU CLICKED ")
	emit_signal("unit_creation", citizen, self)