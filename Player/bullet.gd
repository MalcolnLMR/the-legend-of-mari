extends Area2D

@export var bullet_speed: int = 500

func _process(delta: float) -> void:
	position += Vector2.DOWN * delta * bullet_speed
	
