extends Area2D

@export var speed: int = 400
var screen_size
var Bullet := preload("res://Player/bullet.tscn")

func weapon_logic(_delta: float) -> void:	
	if Input.is_action_just_pressed("shoot"):
		# Creating a bullet scene and adding it to a tree
		var new_bullet = Bullet.instantiate()
		get_tree().root.add_child(new_bullet)
		
		# Setting correct position and rotation to bullet
		new_bullet.global_position = global_position
		new_bullet.rotation = rotation

func flip_y_on_look_at_logic() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

func movement_logic(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	movement_logic(delta)
	weapon_logic(delta)
	
func _physics_process(delta: float) -> void:
	# Rotating object towards mouse cursor
	look_at(get_global_mouse_position())
	flip_y_on_look_at_logic()
