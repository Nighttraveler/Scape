
extends Light2D

# member variables here, example:
# var a=2
# var b="textvar"

onready var anim= get_node("AnimationPlayer")
func _ready():
	# Initialization here
	
	 
	pass




func _on_Area2D_body_enter( body ):
	if body.get_name()=="player":
		
		body.set_moveSpeed(120)
		body.modulate_speed_down()
		anim.play("consume")
		body.start_timer()
		queue_free()
		#_on_Timer_timeout(body)
		
	pass # replace with function body


 
