  
extends Node

onready var player= get_node("player")
onready var plataforms= get_node("plataforms") 
onready var show_score= get_node("Ui/score")
 
onready var lose_label= get_node("Ui/lose_label") 
onready var losepoint= get_node("losepoint")
onready var timer_for_lose=  get_node("Ui/Timer")

var fly_enemy= load("res://enemys/fly-enemy/fly-enemy.scn")
var plataform= load("res://gameObjects/plataforms.scn")
var spring= ResourceLoader.load("res://gameObjects/spring.scn")
var grass1= ResourceLoader.load("res://gameObjects/grass1.scn")
var grass2= ResourceLoader.load("res://gameObjects/grass2.scn")
var cactus= ResourceLoader.load("res://gameObjects/cactus.scn")
var speedUp= ResourceLoader.load("res://gameObjects/speedUp.scn")
var coin =  ResourceLoader.load("res://gameObjects/coin.scn")

var cantidad_plataformas=0
var first=true
var generate_fly_enemy
var last_plataform_ypos
var ypos= 400
var plat_sp
var puntaje=0
 
func _ready():
	# Initialization here
	Globals.set("died",false)
	randomize() 
	 
	generate_fly_enemy= false
	plat_sp=false
	lose_label.hide()	 
	set_fixed_process(true)		
	pass
	
	

func _fixed_process(delta):
	var altura=int(abs(player.get_pos().y))
	#print(Input.get_accelerometer())
	spawn_plataform(delta)
	show_score.set_text(str(Global.get_score()))
	losepoint_set_pos(player.get_pos().y)
	
	if puntaje< abs(player.get_pos().y):
		puntaje= int(abs(player.get_pos().y))
		Global.set_score(puntaje)
	print(Global.get_coins())	
	 
	pass



func random_objects(probal,p):
		
	if probal<=4:
		var c= cactus.instance()
		p.add_child(c)
		c.set_pos(Vector2(  (rand_range(-150,150)), -120 ))
	
	if probal<=5:
		var g= grass1.instance()
		p.add_child(g)
		g.set_pos(Vector2(  (rand_range(-150,150)), -80 ))
		
	if probal>=5:
		var g= grass2.instance()
		p.add_child(g)
		g.set_pos(Vector2(  (rand_range(-150,150)), -80 ))
		
	
	if probal<=1:
		var sp= spring.instance()
		
		if player.get_moveSpeed()<200:
			var speedItem= speedUp.instance()
			p.add_child(speedItem)
			speedItem.set_pos(Vector2(  rand_range(-400,400), -1400 ))
			
		p.add_child(sp)		
		sp.set_pos(Vector2(  (rand_range(-100,100)), -80 ))
		
	pass

func generate_random_p(delta):
	
	while (cantidad_plataformas<10):
		  
		var item_probal= randi()%10		 
		var p=plataform.instance()
		
		random_objects(item_probal,p)
		if plataforms.get_child_count()==0:
			break
		else:
			var lp= plataforms.get_child(plataforms.get_child_count()-1)
			for i in lp.get_children():
				if i.get_name()=="spring":
					plat_sp=true
		
		
		if !plat_sp:
			ypos-=200
			generate_fly_enemy=true		
		else:						
			ypos-=620
			plat_sp=false
			generate_fly_enemy=false
		plataforms.add_child(p)
		p.set_pos(Vector2(rand_range(50,350),ypos))

				
		if item_probal<=6: 
			var c= coin.instance()
			p.add_child(c)
			c.set_pos( Vector2(rand_range(-500,500),rand_range(-100,-500)))
			c.set_z(1)
		last_plataform_ypos=p.get_pos().y
		cantidad_plataformas+=1
	
			 
	if generate_fly_enemy:
		var f= fly_enemy.instance()	
		f.set_pos(Vector2(randf(20,380),last_plataform_ypos+75))
		f.set_target(Vector2(400,f.get_pos().y))
		f.set_scale(Vector2(0.5,0.5))
		plataforms.add_child(f)
	 
	pass
	
func spawn_plataform(delta):
	if first:
		generate_random_p(delta)
		first=false
	if player.get_pos().y<=last_plataform_ypos+200:
		cantidad_plataformas=0		
		generate_random_p(delta)
	 
	pass
	
func delete_p():
	for i in plataforms.get_children():
		if i.get_pos().y>player.get_pos().y+550: 
			i.queue_free()
	
	pass

# LOSEPOINT FUNCTIONS
func losepoint_set_pos(pos):
	if player.get_linear_velocity().y<=0:
		losepoint.set_pos(Vector2(200,pos+350))  
	pass
func lose():
	lose_label.show()
	player.set_axis_velocity(Vector2(0,-800))
	player.anim_player.play("lose")
	Globals.set("died",true)
	timer_for_lose.start()
	
func _on_losepoint_body_enter( body ):
	if body.get_name()=="player":
		lose()

		
	pass # replace with function body

# TIMERS FUNCTIONS

func _on_Timer_delete_p_timeout():
	delete_p()	 
	pass # replace with function body
	
func _on_Timer_timeout():
	get_tree().set_pause(true)
	pass # replace with function body


func _on_Timer_player_menor_speed_timeout():
	if player.get_moveSpeed()>=200:
		player.set_moveSpeed(player.get_moveSpeed()-50)
	
	pass # replace with function body

#BUTTON FUCTIONS

func _on_replay_pressed():
	Global.save_highscore()
	Global.save_cant_coins()
	
	Global.reset_coins()	 
	Global.reset_score()
	
	Global.goto_scene("res://levels/level01.scn")
	get_tree().set_pause(false)
	pass # replace with function body
	
	
func _on_Button_pressed():
	
	Global.save_highscore()
	Global.save_cant_coins()
	
	Global.reset_score()
	Global.reset_coins()
	
	Global.goto_scene("res://gui/main_menu.scn")	
	get_tree().set_pause(false)
	pass # replace with function body