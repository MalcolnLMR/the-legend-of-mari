extends RigidBody2D

signal enemy_death

@export var speed: int = 5
@export var health: int = 3
@export var max_health: int = 3
@export var damage: int = 5
@export var damage_cooldown: float = .5
var is_attack_in_cooldown := false
var attack_timer:float = 0

@onready var Sprite := $Sprite
@onready var Hitbox := $HitBox
@onready var Direction := $Direction

var collision: KinematicCollision2D

var isActive = false
var theresPlayer = false
var Player : Node

func flip_y_on_look_at_logic() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
func die() -> void:
	emit_signal("enemy_death")
	queue_free()

func damage_enemy(_damage: int) -> void:
	if health - _damage <= 0: 
		die()
		return
	
	health -= _damage
	
func heal_enemy(_health: int) -> void:
	if health + _health > max_health: 
		health = max_health
		return
	
	health += _health

func _ready() -> void:
	if is_inside_tree():
		Player = get_tree().get_first_node_in_group("player")	
		if Player != null: theresPlayer = true

func on_collision(collider: Object) -> void:
	if collider.get_groups() == []: return
	match collider.get_groups()[0]:
		"player":
			if not is_attack_in_cooldown: 
				PlayerVariables.damage_player(damage)
				is_attack_in_cooldown = true
		_:
			pass

func _process(delta: float) -> void:
	if is_attack_in_cooldown:
		attack_timer += delta
		if attack_timer >= damage_cooldown:
			attack_timer = 0
			is_attack_in_cooldown = false

func _physics_process(delta: float) -> void:
	if theresPlayer and not isActive: isActive = true
	
	if isActive:
		collision = move_and_collide(Vector2.RIGHT.rotated(Direction.rotation) * speed)
		if collision: on_collision(collision.get_collider())
		Direction.look_at(Player.global_position)
