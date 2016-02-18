
extends VBoxContainer


var high_score_label=null
var game
onready var coins= get_parent().get_node("Coins") 


func _ready():
	# Initialization here
	high_score_label= get_parent().get_node("highscore")
	 
	
	#GET THE HIGH SCORE FROM THE FILE	
	high_score_label.set_text("HighScore "+str(Global.get_saved_highscore()) )
	coins.set_text("Coins "+ str(Global.get_saved_coins_cant()))
	pass




func _on_MenuButton_pressed():
	
	Global.goto_scene("res://levels/level01.scn")	
	pass 


func _on_exit_pressed():
	get_tree().quit()
	pass # replace with function body
