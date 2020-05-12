extends KinematicBody2D

signal hooked

var screen_size
var hook_color =  Color( 0,0,0, 1 )
var speed = 400
var hooked_object

func _ready():
	screen_size = get_viewport_rect().size	

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result
	var velocity = Vector2()
	
	#Déplacements du joueur
	if Input.is_action_pressed("ui_move_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_pressed("ui_right"):
		hooked_object = space_state.intersect_ray(position, Vector2(position.x + 600, position.y), [self])
		if hooked_object: 
			emit_signal("hooked", hooked_object.collider)

#func _draw():
#	draw_line(Vector2(),Vector2(600 ,0),hook_color,4)
