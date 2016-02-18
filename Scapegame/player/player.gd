
extends RigidBody2D

export var Jump_heigth= 650
export var Move_speed= 350 setget set_moveSpeed,get_moveSpeed
export var Player_acceleration= 5 setget set_Player_acceleration,get_Player_acceleration

var feet= null
var feet2=null
 
var current_pos= 0
var act_linear_velocity
var global
 
onready var anim_player= get_node("AnimationPlayer")
var anim=""
var next_anim=""

func _ready():
	# Initialization here
	set_contact_monitor(true)
	feet=get_node("RayCast2D")
	feet2= get_node("RayCast2D1")
	feet.add_exception(self)
	feet2.add_exception(self)	 
	set_fixed_process(true)
	global=get_node("/root/Global")
	 
	 
	pass


func _fixed_process(delta): 
	act_linear_velocity = get_linear_velocity().y
	 
	moving(delta) 
	teleport()
	jump()
	 
 
	
	if anim!=next_anim:
		anim=next_anim
		anim_player.play(anim)
	
	 
func jump():	
	if  act_linear_velocity==0 &&( feet.is_colliding() or feet2.is_colliding() ):
		set_linear_velocity(Vector2(0,-Jump_heigth))
		next_anim="jump"	 
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
	if Globals.get("died")!=true:
		
		if (Input.is_action_pressed("ui_left") or Input.get_accelerometer().x>1):
			move(delta,-Move_speed,Player_acceleration)
			get_node("AnimatedSprite").set_flip_h(true)
			next_anim="walk"
			 
		elif (Input.is_action_pressed("ui_right") or Input.get_accelerometer().x<-1):
			move(delta,Move_speed,Player_acceleration)
			get_node("AnimatedSprite").set_flip_h(false)
			next_anim="walk"
			 
		else:
			move(delta,0,Player_acceleration)
		
	pass

func set_moveSpeed(speed):
	Move_speed=speed
	pass
func get_moveSpeed():
	return Move_speed
	
func set_Player_acceleration(accel):
	Player_acceleration=accel
func get_Player_acceleration():
	return Player_acceleration
	