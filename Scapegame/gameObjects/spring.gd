
extends StaticBody2D

 
var anim=null

func _ready():
	# Initialization here
	anim= get_node("AnimationPlayer")
	pass




func _on_Area2D_body_enter( body ):
	if body.get_name()=="player" and body.get_pos().y<get_node("Area2D").get_pos().y:
		body.set_axis_velocity(Vector2(0,-1200))
		anim.play("spring")
		body.anim.play("jump")
	pass # replace with function body
