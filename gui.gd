extends Control

@onready var health_label := $Label

func update_label():	
	health_label.text = "Vida: " +\
	 str(PlayerVariables.get_health()) +\
	 "/" + str(PlayerVariables.get_max_health())

func _process(delta: float) -> void:
	update_label()
