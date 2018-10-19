extends RigidBody2D


export (int) var sight_range = 50
var motion = Vector2()
var speed = 20

var target = null
var body = null
var target_dir = null

var last_seen = Vector2()
var hidden = -1



func _ready():
	var line = SegmentShape2D.new()
	$SightLine/CollisionShape2D.shape = line
	$SightLine/CollisionShape2D.shape.a = Vector2(0,0)
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = sight_range

func _physics_process(delta):
	
	if target:
		
		$SightLine/CollisionShape2D.shape.b = Vector2(target.global_position - global_position)
		$SightLine/CollisionShape2D.rotation = -rotation
		target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($SightLine.global_rotation)
		if hidden == 0:
			motion += Vector2((target.global_position - global_position).normalized())
			last_seen = (target.global_position - global_position).normalized()
	else:
		motion += Vector2(last_seen)/5
	
	motion = motion.normalized() * speed
	set_linear_velocity(motion)

func _on_DetectRadius_body_entered(body):
	if body.name == "player":
		target= body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null

func _on_SightLine_body_exited(body):
	if body.name != "player":
		hidden -= 1

func _on_SightLine_body_entered(body):
	if body.name != "player":
		hidden += 1
