extends Node

signal player_death

@export var init_health = 10
@export var init_ammo = 10

var health:int = init_health : 
	get: return health
var max_health:int = 100: 
	get: return max_health
var ammo:int = init_ammo: 
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
	health = init_health
	ammo = init_ammo

func die() -> void:
	emit_signal("player_death")
