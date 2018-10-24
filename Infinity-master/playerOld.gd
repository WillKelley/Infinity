extends KinematicBody2D

const UP = Vector2(0, 0) #Sets up as topdown
const MAX_SPEED = 90 # Pixels/second
const ACCELERATION = 20
const FRICTION = 0.15

var motion = Vector2() # single unit used to store (x, y)

var anim=""

func _physics_process(delta):
	print(motion.y)
	print(motion.x)



	if Input.is_action_pressed("ui_down"): #Is S pressed
		motion.y = min(motion.y+ACCELERATION, MAX_SPEED) # accelerate down

	elif Input.is_action_pressed("ui_up"):  # Is W pressed
		motion.y = max(motion.y-ACCELERATION, -MAX_SPEED) # Accelerate up

	else:
		motion.y = lerp(motion.y, 0, FRICTION) # Otherwise add friction in Y plane

	if Input.is_action_pressed("ui_right"): # Is D pressed
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED) # accelerate right

	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)

	else:
		motion.x = lerp(motion.x, 0, FRICTION)

	look_at(get_global_mouse_position()) #point at cursor

	motion = move_and_slide(motion)
	pass