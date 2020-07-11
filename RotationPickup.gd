extends Area

export var rotationIncrease = 0.5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RotationPickup_body_entered(body):
	if body.name == "Player":
		body.rotSpeed *= (1+rotationIncrease)
	for child in get_children():
		child.queue_free()
	queue_free()
	print("DESTROYED")
