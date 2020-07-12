extends Area

export var accelerationIncrease = 0.05

func _on_AccelerationPickUp_body_entered(body):
	if body.name == "Player":
		body.acceleration *= (1+accelerationIncrease)
		body._play_coin_sound()
		body.collected += 1
		if body.collected >= body.winCondition:
			get_tree().change_scene("res://Scenes/EndScene.tscn")
	for child in get_children():
		child.queue_free()
	queue_free()
	print("DESTROYED")
	if body.collected == body.winCondition:
		var error = get_tree().change_scene("res://Scenes/Win.tscn")
		if error:
			print(error)

