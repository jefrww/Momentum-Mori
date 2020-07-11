extends Control


onready var player = get_parent().get_node("Player")


func _process(_delta):
	get_child(0).text = str(player.collected)
