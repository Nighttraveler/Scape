
extends Area2D

var take=false
 
func _ready():
 
	pass
 



func _on_Area2D_body_enter( body ):
	if body.get_name()== "player" && !take:
		body.jetpack()
		take=true
		queue_free()
	pass # replace with function body
