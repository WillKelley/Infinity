extends Area2D

var timer = null
var can_close = false
var time_before_close = 1

func _ready():

	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(time_before_close)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)

func on_timeout_complete():
	can_close = true

func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player" && Input.is_key_pressed(KEY_E):
			
			$anim.play("Open")
			can_close = false
			timer.start()

	if can_close == true:
		$anim.play("Closed")

