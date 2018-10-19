# CLASS
extends AnimatedSprite

# REFERENCES
onready var unit = $"../"

# STATS
var frame_number = 4.0
onready var gather_fps = 10.0 / unit.gather_speed
onready var gather_time = frame_number / gather_fps

# STATE
var transition = null

# FUNCTIONS
func _ready():
	playing = true
	var gather_animation = load("res://unit/citizen/citizen_spriteframes.tres")
	gather_animation.set_animation_speed("gather", gather_fps)

func _process(delta):
	if transition:
		if transition >= 0:
			transition -= delta
		else:
			play("idle")
			transition = null

func gather():
	play("gather")
	transition = gather_time


