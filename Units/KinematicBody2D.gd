extends RigidBody2D

export (int) var engine_thrust

var thrust = Vector2()


var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size

func _process(delta):
	var thrust = Vector2()

	if Input.is_action_pressed("ui_left"):
		thrust += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		thrust += Vector2(1, 0)
	if Input.is_action_pressed("ui_down"):
		thrust += Vector2(0, 1)
	if Input.is_action_pressed("ui_up"):
		thrust += Vector2(0, -1)
	
	thrust = thrust.normalized() * 500

	set_linear_velocity(thrust)
