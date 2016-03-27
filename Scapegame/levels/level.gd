  
extends Node

onready var player= get_node("player")
onready var plataforms= get_node("plataforms") 
onready var show_score= get_node("Ui/score")  
onready var losepoint= get_node("losepoint")
onready var timer_for_lose=  get_node("timers/Timer_for_lose")


var fly_enemy= load("res://enemys/fly-enemy/fly-enemy.scn")
var spring= ResourceLoader.load("res://gameObjects/spring.scn")
var grass1= ResourceLoader.load("res://gameObjects/grass1.scn")
var grass2= ResourceLoader.load("res://gameObjects/grass2.scn")
var cactus= ResourceLoader.load("res://gameObjects/cactus.scn")
var speedUp= ResourceLoader.load("res://gameObjects/speedUp.scn")
var jetpackitem= ResourceLoader.load("res://gameObjects/jetpackitem.scn")
var speedDown= ResourceLoader.load("res://gameObjects/speedDown.scn")
var coin =  ResourceLoader.load("res://gameObjects/coin.scn")

var p_load
var cantidad_plataformas=0
var first=true
var generate_fly_enemy
var last_plataform_ypos
var ypos=-160
var plat_sp
var puntaje=0
var add_miscs= true 
var scoreaux=0
var downpos=10000
 
func _ready():
	# Initialization here
	Globals.set("died",false)
	randomize() 
	p_load= "plataforms" 
	generate_fly_enemy= false
	plat_sp=false	
	set_fixed_process(true)		
	pass
	
	

func _fixed_process(delta):
	 
	
	spawn_plataform()
	show_score.set_text(str(Global.get_score()))
	losepoint_set_pos(player.get_pos().y)	
	 
	if player.get_pos().y-500 <= -65000:
		for i in plataforms.get_children():
			i.set_pos(Vector2(i.get_pos().x,i.get_pos().y+downpos))
		first=true
		ypos+=downpos
		scoreaux+= int(abs(player.get_pos().y))
		last_plataform_ypos=0
		
		player.set_pos(Vector2(player.get_pos().x,player.get_pos().y+downpos))
		
	
	
	puntaje= scoreaux+int(abs(player.get_pos().y))
	if puntaje>Global.get_score():
		Global.set_score(puntaje)
	 
	 
	
	pass



func random_objects(probal,p):
	if (add_miscs):	
		#AGREGO PASTOS Y CACTUS
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
			g.set_pos(Vector2(  (rand_range(-150,150)), -76 ))
	#AGREGO MONEDAS, SPRINGS, SPEEDUP, SPEEDDOWN, JETPACK		
	if probal<=4: 
		var c= coin.instance()
		p.add_child(c)
		c.set_pos( Vector2(rand_range(-500,500),rand_range(-100,-500)))
		c.set_z(1)
			
	if probal<=1:
		var sp= spring.instance()		
		p.add_child(sp)		
		sp.set_pos(Vector2(  (rand_range(-100,100)), -80 ))
		
	if probal<=0.5:
		var speedItem= speedUp.instance()
		p.add_child(speedItem)
		speedItem.set_pos(Vector2(  rand_range(-200,200),rand_range(-400,400) ))
		
	if probal>=9:
		var speedItem= speedDown.instance()
		p.add_child(speedItem)
		speedItem.set_pos(Vector2(  rand_range(-200,200),rand_range(-400,400)))
	
	if probal>=9.5:
		var jetpack= jetpackitem.instance()
		p.add_child(jetpack)
		jetpack.set_pos(Vector2(  rand_range(-200,200),rand_range(-400,400)))
		
	pass

func generate_random_p():
	var plataform= load("res://gameObjects/plataforms/"+p_load+".scn")
	while (cantidad_plataformas<10):
		  
		var item_probal= rand_range(0,10)			 
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
			ypos-=165
			generate_fly_enemy=true		
		else:						
			ypos-=620
			plat_sp=false
			generate_fly_enemy=false
		plataforms.add_child(p)
		p.set_pos(Vector2(rand_range(50,350),ypos))

				

		last_plataform_ypos=p.get_pos().y
		cantidad_plataformas+=1
		 
			 
	if generate_fly_enemy:
		var f= fly_enemy.instance()	
		f.set_global_pos(Vector2(randf(20,380),last_plataform_ypos+52))
		f.set_target(Vector2(400,f.get_pos().y))
		f.set_scale(Vector2(0.5,0.5))
		plataforms.add_child(f)
	 
	pass
	
func spawn_plataform():
	if first:
		generate_random_p()
		first=false
	 
	if player.get_pos().y<=last_plataform_ypos+200:		
		cantidad_plataformas=0		
		generate_random_p()
	 
	pass
	
func delete_p():
	
	for i in plataforms.get_children():
		if i.get_global_pos().y>player.get_pos().y+300: 
			i.queue_free()
	
	pass

# LOSEPOINT FUNCTIONS
func losepoint_set_pos(pos):
	if player.get_linear_velocity().y<=0:
		losepoint.set_pos(Vector2(200,pos+300))  
	pass
func lose():
	get_node("Ui/PopupPanel").show()
	get_node("Ui/PopupPanel/lose_label").show()
	get_node("Ui/PopupPanel/On_pause").hide()
	get_node("Ui/PopupPanel/On_pause").hide()
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
	
func _on_Change_plataforms_to__stone_timeout():
	add_miscs= false
	p_load="plataforms_stone"
	pass # replace with function body

func _on_Change_plataforms_to__wood_timeout():
	p_load="plataforms_wood"
	pass # replace with function body	

func _on_Change_plataforms_to__cake_timeout():
	p_load="plataforms_cake"
	pass # replace with function body
#BUTTON FUCTIONS

func _on_replay_pressed():
	Global.save_dic_data()
	
	
	Global.reset_coins()	 
	Global.reset_score()
	
	Global.goto_scene("res://levels/level01.scn")
	get_tree().set_pause(false)
	pass # replace with function body
	
	
func _on_Button_pressed():
		
	Global.save_dic_data()
	Global.reset_score()
	Global.reset_coins()	
	Global.goto_scene("res://gui/main_menu.scn")	
	get_tree().set_pause(false)
	pass # replace with function body 

var pause=false
func _on_pauseButton_pressed():
	if !pause:
		get_tree().set_pause(true)
		get_node("Ui/PopupPanel").show()
		get_node("Ui/PopupPanel/On_pause").show()
		pause=true
	elif pause:
		if !Globals.get("died"):
			get_node("Ui/PopupPanel").hide()
			get_tree().set_pause(false)
			pause=false
	pass # replace with function body


func _on_back_pressed():

	pass # replace with function body
