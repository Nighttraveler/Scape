  
extends Node

var player= null
var plataforms=null
var show_score= null
var global= null
var lose_label= null
var losepoint=null
var timer_for_lose= null
var plataform= load("res://gameObjects/plataforms.scn")
var spring= ResourceLoader.load("res://gameObjects/spring.scn")
var grass1= ResourceLoader.load("res://gameObjects/grass1.scn")
var grass2= ResourceLoader.load("res://gameObjects/grass2.scn")
var cactus= ResourceLoader.load("res://gameObjects/cactus.scn")

var cantidad_plataformas=0
var first=true
var last_plataform_ypos
var ypos= 400
var next_p_normal= true

func random_objects(probal,p):
		
	if probal<=4:
		var c= cactus.instance()
		p.add_child(c)
		c.set_pos(Vector2(  (rand_range(-100,100)), -120 ))
	
	if probal<=5:
		var g= grass1.instance()
		p.add_child(g)
		g.set_pos(Vector2(  (rand_range(-100,100)), -80 ))
		
	if probal>=5:
		var g= grass2.instance()
		p.add_child(g)
		g.set_pos(Vector2(  (rand_range(-100,100)), -80 ))
		
	
	if probal<=2:
		var sp= spring.instance()
		p.add_child(sp)
		sp.set_pos(Vector2(  (rand_range(-100,100)), -80 ))
		 
		

func generate_random_p(delta):
	
	while (cantidad_plataformas<100):
		  
		var item_probal= rand_range(0,10)		 
		var p=plataform.instance()
		plataforms.add_child(p)
		random_objects(item_probal,p)		
		if next_p_normal:				 
			p.set_pos(Vector2(rand_range(50,350),ypos))
			ypos-=200			
			 
		else:
			ypos-=450
			p.set_pos(Vector2(rand_range(50,350),ypos))
			
			next_p_normal=true
		for sp in p.get_children():
			if sp.get_name()=="spring":
				next_p_normal=false
				
		
		last_plataform_ypos=p.get_pos().y
		cantidad_plataformas+=1 
	 
func _ready():
	# Initialization here
	randomize()
	plataforms= get_node("plataforms")
	player=get_node("player")
	show_score= get_node("Ui/score")
	global= get_node("/root/Global")
	losepoint= get_node("losepoint")
	lose_label= get_node("Ui/lose_label")
	timer_for_lose= get_node("Ui/Timer")
	lose_label.hide()	 
	set_process(true)	
	
	pass
	
	

	
	
func _process(delta):

	spawn_plataform(delta)
	show_score.set_text(str(global.get_score()))
	losepoint_set_pos(player.get_pos().y)
	 
	#print(player.get_linear_velocity().y)
	
	pass

func losepoint_set_pos(pos):
	if player.get_linear_velocity().y<=0:
		losepoint.set_pos(Vector2(200,pos+250))	
			
func spawn_plataform(delta):
	if first:
		generate_random_p(delta)
		first=false
	if player.get_pos().y<=last_plataform_ypos+200:
		cantidad_plataformas=0
		generate_random_p(delta)
		#print(plataforms.get_child_count())		
 
func delete_p():
	for i in plataforms.get_children():
		if i.get_pos().y>player.get_pos().y+2000:
			i.queue_free()

func _on_Timer_delete_p_timeout():
	delete_p()
	#print(player.Move_speed)
	pass # replace with function body


func _on_Button_pressed():
	global.save_highscore()
	global.reset_score()
	global.goto_scene("res://gui/main_menu.scn")
	
	get_tree().set_pause(false)
	
 
	pass # replace with function body


func _on_losepoint_body_enter( body ):
	#if body.get_name()=="player":
	#	lose_label.show()
	#	player.set_axis_velocity(Vector2(0,-800))
	#	player.anim.play("lose")
	#	#player.get_node("Camera2D").set_offset(Vector2(0,100))
	#	
	#	timer_for_lose.start()
		
		
	pass # replace with function body


func _on_Timer_timeout():
	get_tree().set_pause(true)
	pass # replace with function body


func _on_Timer_player_menor_speed_timeout():
	#if player.Move_speed>=130:
	#	player.Move_speed-=50
	
	pass # replace with function body
