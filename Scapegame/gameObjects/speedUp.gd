
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
var anim= null
func _ready():
	# Initialization here
	anim= get_node("AnimationPlayer")
	anim.play("rot")
	pass




func _on_Area2D_body_enter( body ):
	if body.get_name()=="player":
		body.set_moveSpeed(500)
		anim.play("consume")
		
		queue_free()
	pass # replace with function body
