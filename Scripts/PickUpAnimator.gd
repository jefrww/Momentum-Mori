extends MeshInstance


onready var rotationSpeed = 1
onready var bounceSpeed = 0.3
onready var maxHeight = 50
onready var curHeight = 25



func _process(delta):
	rotate_y(rotationSpeed*delta)
	if curHeight >= maxHeight:
		bounceSpeed = abs(bounceSpeed) * -1
	elif curHeight <= 0:
		bounceSpeed = abs(bounceSpeed)
	translate(Vector3.UP* bounceSpeed*delta)
	curHeight += bounceSpeed

