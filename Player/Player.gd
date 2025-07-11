extends Area2D

@export var speed: int = 400
var screen_size
var bullet = preload("res://bullet.tscn").instantiate()

func weapon_logic(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):		
		add_sibling(bullet)

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
