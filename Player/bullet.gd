extends Area2D

# Speed of the bullet
@export var speed : int = 500

# Change position towards rotation
func _process(delta: float) -> void:
	position += transform.x * speed * delta

# When object leaves the screen > delete it from tree
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
