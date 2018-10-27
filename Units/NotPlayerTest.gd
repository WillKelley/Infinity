extends RigidBody2D

# BASIC VARIABLES FOR MOVMENT/ SIGHT
var sight_range = 50
var motion = Vector2()
var speed = 10
var rotation_speed = 2

# LINE OF SIGHT CHECK VARS
var target = null
var body = null
var target_dir = null
var current_dir = null
var hidden = -1
var out_of_sight = null

# TIMER VARIABLES
var is_idle = true
var timer_idle = null
var rotation_dir = 1
var rotation_time = 3

var direction = 2

func _ready():
	randi()
	# CREATE IDLE TIMER
	timer_idle = Timer.new()
	timer_idle.set_one_shot(false)
	timer_idle.set_wait_time(rotation_time)
	timer_idle.connect("timeout", self, "on_timeout_complete")
	add_child(timer_idle)

	timer_idle.start()

	# CREATE NEW HITBOX FOR SIGHTLINE & MAKE BASE ON BODY
	var line = SegmentShape2D.new()
	$SightLine/CollisionShape2D.shape = line
	$SightLine/CollisionShape2D.shape.a = Vector2(0,0)

	#CREATE NEW HITBOX CIRCLE FOR DETECT RADIUS
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = sight_range

	rotate(randi())

func _physics_process(delta):

	if is_idle:
		motion = Vector2(rotation_dir, 0).rotated(global_rotation)
		applied_torque = 85 * rotation_dir

	if out_of_sight:
		timer_idle.set_paused(false)
		$SightLine/CollisionShape2D.shape.b = Vector2(0 ,0)
		motion = Vector2(0,0)

	if target:

		$SightLine/CollisionShape2D.shape.b = Vector2(target.global_position - global_position)
		$SightLine/CollisionShape2D.rotation = -rotation

		target_dir = (target.global_position - global_position).normalized()  # USED TO FIND IF IN FRONT
		current_dir = Vector2(1, 0).rotated($SightLine.global_rotation)   # FIND IN FRONT CONT.

		# IF NOTHING IS INBETWEEN PLAYER AND IF IS IN A 90 DEG. CONE

	if  target != null:
		if hidden == 0 && target_dir.dot(current_dir) > 0.6:
			applied_torque = 0
			timer_idle.set_paused(true)
			print('see')
			rotation = current_dir.linear_interpolate(target_dir, rotation_speed * delta).angle() #ROTATE PLAYER TO FACE
			motion -= Vector2((target.global_position - global_position).normalized())  #More Movement
		else:
			out_of_sight = target
	else:
		out_of_sight = target

	motion = motion.normalized() * speed
	set_linear_velocity(motion)

func _on_SightLine_body_exited(body):
	if body != target:
		hidden -= 1
		if target == null:
			hidden = 0
			out_of_sight = body

func _on_SightLine_body_entered(body):
	if body != target:
		hidden += 1

func _on_DetectRadius_body_entered(body):
	if body.has_method('player'): # CHECKS TO SEE IF IT IS FOLLOWABLE
		target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null

func on_timeout_complete():
	print('idle')
	is_idle = true
	rotation_dir = (-1 * rotation_dir)