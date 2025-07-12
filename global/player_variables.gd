extends Node

var health:int = 100
var max_health:int = health

func get_health() -> int:
	return health
	
func get_max_health() -> int:
	return max_health

func damage_player(damage:int) -> void:
	if damage > health:
		die()
		return
	
	health -= damage
	
func heal_player(healing:int) -> void:
	if healing + health > max_health:
		health = max_health
	else:
		health += healing

func die() -> void:
		# TODO
		pass
