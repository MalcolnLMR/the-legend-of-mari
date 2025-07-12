extends Control

@onready var health_label := $Health
@onready var ammo_label := $Ammo
@onready var camera

func update_label():	
	health_label.text = "Vida: " +\
	 str(PlayerVariables.health) +\
	 "/" + str(PlayerVariables.max_health)
	
	ammo_label.text = "Munição: " +\
	 str(PlayerVariables.ammo) +\
	 "/" + str(PlayerVariables.max_ammo)

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")

func _process(delta: float) -> void:
	update_label()

#func _physics_process(delta: float) -> void:	
	#position = camera.position
