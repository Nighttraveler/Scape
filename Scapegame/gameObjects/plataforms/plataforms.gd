
extends Sprite

#var touch= false 
var global=null

func _ready():
	# Initialization here
	global= get_node("/root/Global") 
	
	pass

func _on_Area2D_body_enter( body ):
	#if body.get_name()=="player" and body.get_pos().y<get_pos().y :#and !touch:
		 
		#body.set_axis_velocity(Vector2(0,-650))
		#touch=true
	pass # replace with function body
