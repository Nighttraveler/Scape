  
extends Node

var player= null
var plataforms=null
var show_score= null
var global= null
var lose_label= null
var losepoint=null
var timer_for_lose= null
var plataform= load("res://gameObjects/plataforms.scn")


var cantidad_plataformas=0
var first=true
var last_plataform_ypos
var ypos= 400


func generate_random_p(delta):
	 
	while (cantidad_plataformas<5): 		
		var p=plataform.instance()
		p.set_pos(Vector2(rand_range(50,350),ypos))			 
		plataforms.add_child(p)
		 
		ypos-=195
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
func losepoint_set_pos(pos):
	if player.get_linear_velocity().y<=0:
		losepoint.set_pos(Vector2(200,pos+1000))
	
	
func _process(delta):

	spawn_plataform(delta)
	show_score.set_text(str(global.get_score()))
	losepoint_set_pos(player.get_pos().y)
	#print(player.get_linear_velocity().y)
	
	pass
	
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
		if i.get_pos().y>player.get_pos().y+550:
			i.queue_free()

func _on_Timer_delete_p_timeout():
	delete_p()
	pass # replace with function body


func _on_Button_pressed():
	global.goto_scene("res://gui/main_menu.scn")
	global.save_highscore()
	get_tree().set_pause(false)
	
 
	pass # replace with function body


func _on_losepoint_body_enter( body ):
	if body.get_name()=="player":
		lose_label.show()
		player.set_axis_velocity(Vector2(0,-800))
		player.anim.play("lose")
		
		timer_for_lose.start()
		
		
	pass # replace with function body


func _on_Timer_timeout():
	get_tree().set_pause(true)
	pass # replace with function body
