
extends AnimatedSprite


var taken = false
func _ready():
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if body.get_name()=="player" && !taken:
		get_node("/root/Global").set_score(10)
		taken=true
		get_node("AnimationPlayer").play("taken")
		
		
	pass # replace with function body
