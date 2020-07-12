extends Spatial

export var rotationSpeed = - 0.1
export(NodePath) var player
onready var preRot = 1

func _process(delta):
	var curRot = transform.basis.z.angle_to(Vector3(0,0,1))
	if get_node(player).collected >=5 &&  curRot < preRot:
		rotate_x(rotationSpeed*delta)
		preRot = curRot
	
