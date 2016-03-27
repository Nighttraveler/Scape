extends KinematicBody2D

var current_speed = 0
export var MAX_SPEED = 200
export var acceleration = 500 
var target setget set_target,get_target

var initialpos
var is_moving_to_target=true
func _ready():
	set_fixed_process(true)
	initialpos= get_pos()
	#set_target(Vector2(400,get_pos().y))
	pass
	
	
func set_target(targetpos):
	target=targetpos
func get_target():
	return target

func _fixed_process(delta):
	
	
	if is_moving_to_target:
		move_towards(target,delta)	
			
	else:
		move_towards(initialpos ,delta)
		if get_pos()==initialpos:
			is_moving_to_target=true	
 	
			 
	current_speed += acceleration*delta
	current_speed = clamp(current_speed,0,MAX_SPEED)
 
	 
	
func move_towards(target,delta):
	#var target_pos= target.get_pos()
	var wanted_mov = target-get_pos() #target_pos
	var mov = (wanted_mov.normalized()*current_speed*delta)
	
	if (wanted_mov.length_squared()<mov.length_squared()):
		move(wanted_mov)
		is_moving_to_target=false
		
	else:
		move(mov)
			

	if (target.x<=get_pos().x):
		get_node("AnimatedSprite").set_flip_h(true)
		
	else:
		get_node("AnimatedSprite").set_flip_h(false)
 




func _on_Area2D_body_enter( body ):
	if body.get_name()== "player" && body.can_die==true:
		get_node("/root/world").lose()
	pass # replace with function body
