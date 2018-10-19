# CLASS
extends AnimatedSprite

# REFERENCES
onready var unit = $"../"

# STATS
var frame_number = 4.0
onready var attack_fps = 10.0 / unit.attack_speed
onready var attack_time = frame_number / attack_fps

# STATE
var transition = null

# FUNCTIONS
func _ready():
	playing = true
	var attack_animation = load("res://unit/warrior/WarriorSprite.tscn::1")
	attack_animation.set_animation_speed("attack", attack_fps)

func _process(delta):
	if transition:
		if transition >= 0:
			transition -= delta
		else:
			play("idle")
			transition = null

func attack():
	play("attack")
	transition = attack_time