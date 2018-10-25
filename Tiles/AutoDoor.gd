extends Area2D

var timer = null
var can_close = false

func _ready():
	
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(1) 
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)

func on_timeout_complete():
	can_close = true

func _on_door_body_entered(body):
	if body is preload("res://player.gd"):
		print(body)
		$anim.play("Open")
	can_close = false
	
	timer.start()

func _process(delta):
	if can_close == true:
		$anim.play("Closed")
		
