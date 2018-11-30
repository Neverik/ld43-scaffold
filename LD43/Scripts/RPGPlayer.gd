extends KinematicBody2D

export (int) var speed = 200
export var clicker = false
var target = Vector2()
export var do_shoot = false
export var bullet = ""
onready var muzzle = $Muzzle

var velocity = Vector2()

func _ready():
	if do_shoot:
		bullet = load(bullet)

func get_input():
	if not clicker:
	    velocity = Vector2()
	    if Input.is_action_pressed('Right'):
	        velocity.x += 1
	    if Input.is_action_pressed('Left'):
	        velocity.x -= 1
	    if Input.is_action_pressed('Down'):
	        velocity.y += 1
	    if Input.is_action_pressed('Up'):
	        velocity.y -= 1
	    velocity = velocity.normalized() * speed

func _physics_process(delta):
	if clicker:
		velocity = (target - position).normalized() * speed
		if (target - position).length() > 5:
			move_and_slide(velocity)
	else:
	    get_input()
	    move_and_slide(velocity)
	if do_shoot:
		look_at(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed('Click'):
		if clicker:
			target = get_global_mouse_position()
		if do_shoot:
			shoot()
    

func shoot():
	var b = bullet.instance()
	b.global_position = muzzle.global_position
	b.global_rotation = muzzle.global_rotation
	get_parent().add_child(b)
	print("pew")