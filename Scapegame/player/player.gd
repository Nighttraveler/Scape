
extends RigidBody2D

export var Jump_heigth= 200
export var Move_speed= 500
export var Player_acceleration= 5

var feet= null
var feet2=null
var anim= null
var current_pos= 0
var act_linear_velocity

 

func _ready():
	# Initialization here
	set_contact_monitor(true)
	feet=get_node("RayCast2D")
	feet2= get_node("RayCast2D1")
	feet.add_exception(self)
	feet2.add_exception(self)
	anim=get_node("AnimationPlayer")
	set_fixed_process(true)
	
	pass


func _fixed_process(delta): 
	act_linear_velocity = get_linear_velocity().y
	moving(delta) 
	teleport()
	jump() 
	
	
	
	 
func jump():	
	if  act_linear_velocity==0 &&( feet.is_colliding() or feet2.is_colliding() ):
		set_linear_velocity(Vector2(0,-Jump_heigth))
		anim.play("jump")	 
		
	 
	pass





func teleport():
	if get_pos().x<0:
		set_pos(Vector2(400,get_pos().y))
	elif get_pos().x>400:
		set_pos(Vector2(0,get_pos().y))
		
func move(delta,sp,acc):
	current_pos= lerp(current_pos,sp,acc*delta)
	set_linear_velocity(Vector2(current_pos,get_linear_velocity().y))
	pass

func moving(delta):
	if (Input.is_action_pressed("ui_left")):
		move(delta,-Move_speed,Player_acceleration)
		get_node("AnimatedSprite").set_flip_h(true)
		anim.play("walk")
	elif (Input.is_action_pressed("ui_right")):
		move(delta,Move_speed,Player_acceleration)
		get_node("AnimatedSprite").set_flip_h(false)
		anim.play("walk")
	else:
		move(delta,0,Player_acceleration)
		
	 
		
	

 

