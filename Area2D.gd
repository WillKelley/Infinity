extends Area2D

#var timer = null

#func _ready():
	
	
	
func _process(delta):
	
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player" && Input.is_key_pressed(KEY_E):
			$AnimationPlayer.play("open")
		elif body.name == "player" && Input.is_key_pressed(KEY_E):
			$AnimationPlayer.play("close")
		