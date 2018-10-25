extends RigidBody2D

var sight_range = 75
var motion = Vector2()
var speed = 10
var rotation_speed = 2

var target = null
var body = null
var target_dir = null
var rot_dir = 0

var hidden_bodies = 0

var last_seen = Vector2()
var dest = Vector2()
var hidden = -1

var out_of_sight = null

func _ready():
	var line = SegmentShape2D.new()
	$SightLine/CollisionShape2D.shape = line
	$SightLine/CollisionShape2D.shape.a = Vector2(0,0)
	
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = sight_range

func _physics_process(delta):
	print(hidden)
	if out_of_sight:
		
		$SightLine/CollisionShape2D.shape.b = Vector2(0 ,0)
		
	if target:
		
		$SightLine/CollisionShape2D.shape.b = Vector2(target.global_position - global_position)
		$SightLine/CollisionShape2D.rotation = -rotation
		
		target_dir = (target.global_position - global_position).normalized()  # USED TO FIND IF IN FRONT
		var current_dir = Vector2(1, 0).rotated($SightLine.global_rotation)   # FIND IN FRONT CONT.

		# IF NOTHING IS INBETWEEN PLAYER AND IF IS IN A 90 DEG. CONE
		if hidden == 0 && target_dir.dot(current_dir) > 0.5: 
			rotation = current_dir.linear_interpolate(target_dir, rotation_speed * delta).angle() #ROTATE PLAYER TO FACE
			motion += Vector2((target.global_position - global_position).normalized())  #More Movement
#			last_seen = (target.global_position - global_position).normalized()
#			dest = target.global_position
		else:
#			target_dir = rotation
#			rotation = current_dir.linear_interpolate(target_dir, rotation_speed * delta).angle()
			motion = Vector2(0, 0)
	else:
			motion = Vector2(0, 0)
#	rotation += rotation_speed * rot_dir * delta
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
	if body.has_method('player'): # CHEDKS TO SEE IF IT IS FOLLOWABLE
		hidden_bodies += 1
		target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null
