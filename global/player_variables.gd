extends Node

signal player_death

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

func recharge_ammo(ammo_to_add:int) -> void:
	if ammo_to_add + ammo > max_ammo:
		ammo = max_ammo
	else:
		ammo += ammo_to_add

func reset_player() -> void:
	health = 100
	ammo = 20

func die() -> void:
	emit_signal("player_death")
