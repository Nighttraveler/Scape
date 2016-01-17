
extends Node
#FILE
var savegame= File.new()


var score=0
var save_path= "user://savegame.bin" 

#BY NOW JUST SAVE THE HIGH SCORE
var save_data= {"highscore":score}


func _ready():
	# Initialization here
	check_savegame()
	pass
	
	
func check_savegame():
	if not savegame.file_exists(save_path):
		savegame.open(save_path,File.WRITE)
		#SAVE THE DICC
		savegame.store_var(save_data)
		savegame.close()	
	pass
	
func get_saved_highscore():
	savegame.open(save_path,File.READ)
	var s= savegame.get_var()
	savegame.close()
	return s["highscore"]
	pass
	
func save_highscore():
	if get_saved_highscore()<get_score():
		savegame.open(save_path,File.WRITE)
		savegame.store_var(save_data)
		savegame.close()
	pass
	
func set_score():
	score+=1
	save_data["highscore"]=score
func get_score():
	return score
