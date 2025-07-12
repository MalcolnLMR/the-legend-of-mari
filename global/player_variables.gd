extends Node

var health:int = 100 : 
	get: return health
var max_health:int = health: 
	get: return max_health
var ammo:int = 20: 
	get: return ammo
var max_ammo:int = 100: 
	get: return max_ammo

func can_shoot() -> bool:
	if ammo > 0:
		ammo -= 1
		return true	
	return false

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
