
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"
var game
func _ready():
	# Initialization here
	pass




func _on_MenuButton_pressed():
	
	var g= load("res://levels/level01.scn")
	game = g.instance()
	
	get_tree().get_root().add_child(game)
	queue_free()
	
	pass # replace with function body
