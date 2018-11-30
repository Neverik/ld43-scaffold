extends KinematicBody2D

var velocity = Vector2 (0, 0)
export var gravity_acceleration = Vector2( 0, 1 )
export var strong_gravity_acceleration = Vector2( 0, 1.2 )
export var jump_force = Vector2( 0, -10 )
export var jump_gravity_acceleration = Vector2( 0, 0.04 )
export var move_force = Vector2( 300, 0 )
export var shift_move_force = Vector2( 450, 0 )
export var max_jump_time = 0.7
var on_ground = false
var fast = true
var can_jump = false
var jump_time = 0.0

func _physics_process(delta):
	move_and_collide(velocity)
	if test_move(get_transform(), Vector2 (0, -1)):
		velocity.y = 0
	if test_move(get_transform(), Vector2 (0, 1)):
		velocity = Vector2 (0, 0)
		on_ground = true
	else:
		if velocity.y > 0:
			velocity += strong_gravity_acceleration
		elif can_jump:
			velocity += jump_gravity_acceleration
		else:
			velocity += gravity_acceleration
		on_ground = false
	if Input.is_action_pressed ("Space"):
		if on_ground:
			can_jump = true
			if Input.is_action_just_pressed ("Space"):
				jump ()
		if can_jump:
			jump_time += delta
		if jump_time > max_jump_time:
			can_jump = false
			jump_time = 0
	else:
		can_jump = false
	if Input.is_action_pressed ("Right"):
		right ()
	elif Input.is_action_pressed ("Left"):
		left ()
	else:
		velocity.x = 0
	
	if not on_ground:
		set_anim("jump")
	elif Input.is_action_pressed ("Right") or Input.is_action_pressed ("Left"):
		set_anim("run")
	else:
		set_anim("default")

func jump ():
	velocity.y = jump_force.y

func right ():
	if fast:
		move_and_slide (shift_move_force)
	else:
		move_and_slide (move_force)
	set_flip(false)

func left ():
	if fast:
		move_and_slide (-shift_move_force)
	else:
		move_and_slide (-move_force)
	set_flip(true)

func set_flip(n):
	pass

func set_anim(s):
	pass
