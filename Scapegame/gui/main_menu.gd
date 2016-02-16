
extends VBoxContainer


var high_score_label=null
var game
 


func _ready():
	# Initialization here
	high_score_label= get_parent().get_node("highscore")
	 
	
	#GET THE HIGH SCORE FROM THE FILE	
	high_score_label.set_text("High Score "+str(Global.get_saved_highscore()) )
	pass




func _on_MenuButton_pressed():
	
	Global.goto_scene("res://levels/level01.scn")	
	pass 


func _on_exit_pressed():
	get_tree().quit()
	pass # replace with function body
