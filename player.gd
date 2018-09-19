extends KinematicBody2D

const UP = Vector2(0, 0) #Sets up as topdown
const MAX_SPEED = 100 # Pixels/second
const ACCELERATION = 25 

var motion = Vector2() # single unit used to store (x, y)

func _physics_process(delta):

	if Input.is_action_pressed("ui_down"):
		motion.y = min(motion.y+ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_up"):
		motion.y = max(motion.y-ACCELERATION, -MAX_SPEED)
	
	else:
		motion.y = lerp(motion.y, 0, 0.2)
		
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)

	else:
		motion.x = lerp(motion.x, 0, 0.2)


	motion = move_and_slide(motion)
	pass