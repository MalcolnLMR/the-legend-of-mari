extends RigidBody2D

var type: String = "health"
@export var health: int = 10
var collision: KinematicCollision2D
# some quando pega
# aumenta munição em 10

func die():
	queue_free()

func _on_body_entered(body: Node) -> void:
	match body.get_groups()[0]:
		"player":
			PlayerVariables.heal_player(health)
			die()
		_:
			pass
