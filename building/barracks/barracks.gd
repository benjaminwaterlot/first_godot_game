# CLASS
extends "../building.gd"

# REFERENCES
var warrior = preload("res://unit/warrior/Warrior.tscn")

# FUNCTIONS
func on_button_click():
	emit_signal("unit_creation", warrior, self)