extends RigidBody2D

var type: String = "arrow"
@export var ammo_qtd: int = 10
var collision: KinematicCollision2D
# some quando pega
# aumenta munição em 10

func die():
	queue_free()

func _on_body_entered(body: Node) -> void:
	match body.get_groups()[0]:
		"player":
			PlayerVariables.recharge_ammo(ammo_qtd)
			die()
		_:
			pass
