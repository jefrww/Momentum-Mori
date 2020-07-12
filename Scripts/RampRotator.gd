extends Spatial

export var rotationSpeed = - 0.1
export(NodePath) var player
onready var preRot = 1
export(NodePath) var pathToSFX
onready var soundPlayer = get_node(pathToSFX) 
onready var soundPlayable = true

func _process(delta):
	var curRot = transform.basis.z.angle_to(Vector3(0,0,1))
	if get_node(player).collected >=63 &&  curRot < preRot:
		if soundPlayable:
			soundPlayable = false
			soundPlayer.play(0.0)
		rotate_x(rotationSpeed*delta)
		preRot = curRot
