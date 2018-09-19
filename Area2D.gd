extends Area2D

func _on_door_body_enter( body ):
	$anim.play("open")
	pass