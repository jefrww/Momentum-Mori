extends Label


onready var player = get_parent().get_node("Player")


func _process(_delta):
	text = str(player.collected)
