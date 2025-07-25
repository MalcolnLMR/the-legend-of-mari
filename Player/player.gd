extends CharacterBody2D

var player := true

var speed: int = 400
@export var sprint_speed: int = 600
@export var normal_speed: int = 400
var anim_speed: int = 0
var offset_to_look_up: int = 100
var screen_size
var Bullet := preload("res://Player/bullet.tscn")
@onready var Collision := $CollisionShape2D
@onready var Sprite := $AnimatedSprite2D
@onready var BowParent := $Node2D
@onready var Bow := $Node2D/Sprite2D
var isWalking := false

func weapon_logic(_delta: float) -> void:	
	if Input.is_action_just_pressed("shoot") and PlayerVariables.can_shoot():
		# Creating a bullet scene and adding it to a tree
		var new_bullet = Bullet.instantiate()
		get_tree().root.add_child(new_bullet)
		
		# Setting correct position and rotation to bullet
		new_bullet.global_position = Bow.global_position
		new_bullet.rotation = BowParent.rotation

func change_sprite_when_look_up() -> void:	
	if isWalking:
		anim_speed = 2
	else:
		anim_speed = 0
			
	if get_global_mouse_position().x + offset_to_look_up < position.x:
		Sprite.play("looking_right", anim_speed); Sprite.scale.x = -3; return
	elif get_global_mouse_position().x - offset_to_look_up > position.x:
		Sprite.play("looking_right", anim_speed); Sprite.scale.x = 3; return
	if get_global_mouse_position().y < position.y:
		Sprite.play("looking_up", anim_speed); return
	else:
		Sprite.play("looking_down", anim_speed); return


func flip_x_when_look_left() -> void:
	if get_global_mouse_position().x > position.x:
		Sprite.scale.x = 3
	else:
		Sprite.scale.x = -3

func change_sprite_when_walking() -> void:
	if velocity == Vector2.ZERO: return
	if velocity.y < 0: Sprite.play("looking_up"); return
	if velocity.y > 0: Sprite.play("looking_down"); return
	if velocity.x < 0: Sprite.play("looking_right"); return
	if velocity.x > 0: Sprite.play("looking_left"); return
	

func movement_logic(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_just_pressed("sprint"):
		speed = sprint_speed
	elif Input.is_action_just_released("sprint"):
		speed = normal_speed
	
	if velocity.length() > 0:
		isWalking = true
		velocity = velocity.normalized() * speed
	else:
		isWalking = false
	
	move_and_slide()

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):	
	weapon_logic(delta)
	change_sprite_when_look_up()
	
func _physics_process(delta: float) -> void:
	movement_logic(delta)	
	
	# Rotating weapon towards mouse cursor
	BowParent.look_at(get_global_mouse_position())
	#flip_x_when_look_left()
	
