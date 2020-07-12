extends Control


func _on_StartButton_pressed():
	print("STARTING")
	var error = get_tree().change_scene("res://Scenes/Level1.tscn")
	if error:
		print(error)

func _on_ExitButton_pressed():
	print("BYE")
	get_tree().quit()
