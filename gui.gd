extends Control

@onready var health_label := $Health
@onready var ammo_label := $Ammo

func update_label():	
	health_label.text = "Vida: " +\
	 str(PlayerVariables.health) +\
	 "/" + str(PlayerVariables.max_health)
	
	ammo_label.text = "Munição: " +\
	 str(PlayerVariables.ammo) +\
	 "/" + str(PlayerVariables.max_ammo)

func _process(delta: float) -> void:
	update_label()
