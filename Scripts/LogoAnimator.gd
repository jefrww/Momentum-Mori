extends Sprite

onready var bounceSpeed = 1
onready var maxHeight = 100
onready var curHeight = 50

func _process(delta):
	if curHeight >= maxHeight:
		bounceSpeed = abs(bounceSpeed) * -1
	elif curHeight <= 0:
		bounceSpeed = abs(bounceSpeed)
	translate(Vector2.UP* bounceSpeed*delta)
	curHeight += bounceSpeed
