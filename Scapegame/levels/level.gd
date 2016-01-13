  
extends Node2D

var player= null
var plataforms

var cantidad_plataformas=0
var first=true
var plataform= load("res://gameObjects/plataforms.scn")
var last_plataform_ypos
var ypos= 400


func generate_random_plat(delta):
	 
	while (cantidad_plataformas<5): 
		
		var p=plataform.instance()
		p.set_pos(Vector2(randi()%400,ypos))			 
		plataforms.add_child(p)
		p.translate(Vector2(0,120*delta))	
		ypos-=200
		last_plataform_ypos=p.get_pos().y
		cantidad_plataformas+=1
		
	 
	 	 
	
func _ready():
	# Initialization here
	randomize()
	plataforms= get_node("plataforms")
	player=get_node("RigidBody2D")
	#generate_p(400)
	set_process(true)
	 
	
	pass

func _process(delta):
	print(player.get_pos().y, last_plataform_ypos)

	move_plataform(delta)
	pass
	
func move_plataform(delta):
	if first:
		generate_random_plat(delta)
		first=false
	elif player.get_pos().y<=last_plataform_ypos:
		cantidad_plataformas=0
		generate_random_plat(delta)
		
	#if plataforms.get_pos().y<=1500:	
		#plataforms.translate(Vector2(0,120*delta))
	#else:
	#	plataforms.set_pos(Vector2(0,0))
	#	cantidad_plataformas=-1
	#	generate_random_plat()
	#if plataforms.get_child_count()==1:
	#	generate_random_plat(delta)
		
	print(plataforms.get_child_count())
	
 
