extends Area

export var accelerationIncrease = 1

func _on_AccelerationPickUp_body_entered(body):
	if body.name == "Player":
		body.acceleration += accelerationIncrease
	for child in get_children():
		child.queue_free()
	queue_free()
	print("DESTROYED")

