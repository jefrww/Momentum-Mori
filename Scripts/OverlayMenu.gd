extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_overlay"):
		if get_tree().paused:
			cont_game()
		else:
			pause_game()

func pause_game():
	if get_tree().get_current_scene().get_name() != "WinScene":
		get_tree().paused = true
		visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_child(0).play(0.0)
	
	
func cont_game():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_child(0).stop()


func _on_ContinueButton_pressed():
	cont_game()

func _on_BackToMainButton_pressed():
	get_tree().paused = false
	var error = get_tree().change_scene("res://Scenes/MainMenu.tscn")
	if error:
		print(error)

func _on_ExitButton_pressed():
	get_tree().quit()
