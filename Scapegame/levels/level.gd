  
extends Node2D

var player= null
var plataforms
var cantidad_plataformas=0
var primera=true
 
  
func generate_random_plat(delta):
	var y=-50
	while (cantidad_plataformas<20): 
		var plataform= load("res://gameObjects/plataforms.scn")
		var p=plataform.instance()
		p.set_pos(Vector2(randi()%250,y))
			 
		plataforms.add_child(p)
		p.translate(Vector2(0,120*delta))	
		y=y-200
		cantidad_plataformas+=1
	 
	 	 
	
func _ready():
	# Initialization here
	randomize()
	plataforms= get_node("plataforms")
	#generate_p(400)
	set_process(true)
	 
	
	pass

func _process(delta):

	move_plataform(delta)
	pass
	
func move_plataform(delta):
	if primera:
		generate_random_plat(delta)
		primera=false
	#if plataforms.get_pos().y<=1500:	
		#plataforms.translate(Vector2(0,120*delta))
	#else:
	#	plataforms.set_pos(Vector2(0,0))
	#	cantidad_plataformas=-1
	#	generate_random_plat()
	#if plataforms.get_child_count()==1:
	#	generate_random_plat(delta)
		
	print(plataforms.get_child_count())
	
 
