
extends Sprite

var touch= false 
var global=null

func _ready():
	# Initialization here
	global= get_node("/root/Global") 
	
	pass

func _on_Area2D_body_enter( body ):
	if body.get_name()=="player" and body.get_pos().y<get_pos().y and !touch:
		 
		
		touch=true
	pass # replace with function body
