
extends StaticBody2D

 
var anim=null
 
var global= null
func _ready():
	# Initialization here
	anim= get_node("AnimationPlayer")
	global = get_node("/root/Global")
	 
	pass




func _on_Area2D_body_enter( body ):

	if body.get_name()=="player" and abs(body.get_pos().y)>abs(get_node("Area2D").get_pos().y):
		body.set_axis_velocity(Vector2(0,-1100))
		global.set_score( 5)
		anim.play("spring")		
		body.anim.play("jump")
	pass # replace with function body
