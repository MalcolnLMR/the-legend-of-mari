extends RigidBody2D

var bullet := true

# Speed of the bullet
@export var speed : int = 15
@export var damage: int = 1
var collision: KinematicCollision2D
var collider: Object

func die():
	queue_free()

func _physics_process(delta: float) -> void:	
	collision = move_and_collide(Vector2.RIGHT.rotated(rotation) * speed)
	if collision: 
		collider = collision.get_collider()
		match collider.get_groups()[0]:
			"bullet": 
				collider.die()
			"enemy": 
				collider.damage_enemy(damage)
			_: pass
		die()

# When object leaves the screen > delete it from tree
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()
