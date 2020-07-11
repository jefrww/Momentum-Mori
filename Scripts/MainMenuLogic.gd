extends Control


func _on_StartButton_pressed():
	print("STARTING")
	get_tree().change_scene("res://Scenes/Level0.tscn")


func _on_ExitButton_pressed():
	print("BYE")
	get_tree().quit()
