
extends Node
#FILE
var savegame= File.new()

var score=0	setget set_score,get_score
var coins=0 setget set_coins,get_coins
var save_path= "user://savegame.bin"
var current_scene= null 

#BY NOW JUST SAVE THE HIGH SCORE
var save_data= {"highscore":score, "coins":coins}


func _ready():
	# Initialization here
	check_savegame()
	
	var root= get_tree().get_root()
	current_scene= root.get_child( root.get_child_count()-1 )
	
	pass

func goto_scene(path):
	
	call_deferred("_deferred_goto_scene",path)
	
	pass

func _deferred_goto_scene(path):
	
	current_scene.free()		
	var s= ResourceLoader.load(path)
	current_scene= s.instance()	
	get_tree().get_root().add_child(current_scene)	
	get_tree().set_current_scene(current_scene)
	
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
	
func save_dic_data():
	save_data["coins"]= get_saved_coins_cant()+coins
	if get_saved_highscore()<get_score():
		save_data["highscore"]= score
		savegame.open(save_path,File.WRITE)
		savegame.store_var(save_data)
		savegame.close()
	pass
	
func get_saved_coins_cant():
	savegame.open(save_path,File.READ)
	var s= savegame.get_var()
	savegame.close()
	return s["coins"]
	
		

	
	
func reset_score():
	score=0	
func set_score(scr):
	score= scr
		
func get_score():
	return score
	
func reset_coins():
	coins=0 
func set_coins(coin):
	coins+=coin	
func get_coins():
	return coins