extends Node2D


func _ready():
	if Input.is_action_pressed("ui_accept"):
		
		$anim.play("Open")

	
	
	