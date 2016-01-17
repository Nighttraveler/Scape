
extends VBoxContainer


var high_score_label=null
var game
var global=null
var savegame= File.new()

func _ready():
	# Initialization here
	high_score_label= get_parent().get_node("highscore")
	global=get_node("/root/Global")
	
	#GET THE HIGH SCORE FROM THE FILE
	savegame.open(global.save_path,File.READ)	
	var savedata= savegame.get_var()	
	savegame.close()
	
	high_score_label.set_text("High Score "+str(savedata["highscore"]) )
	pass




func _on_MenuButton_pressed():
	
	var g= load("res://levels/level01.scn")
	game = g.instance()
	
	get_tree().get_root().add_child(game)
	get_parent().queue_free()
	
	pass # replace with function body


func _on_exit_pressed():
	get_tree().quit()
	pass # replace with function body
