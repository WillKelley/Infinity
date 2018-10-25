extends RigidBody2D

var motion = Vector2()
var speed = 85

var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size

func _process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)

	motion = motion.normalized() * speed
	

	set_linear_velocity(motion)

func player():
	1 == 1

