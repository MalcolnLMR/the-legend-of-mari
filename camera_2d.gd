extends Camera2D

@export var lerp_speed = 3.0
@export var target: Node2D
@export var _offset = Vector2.ZERO
var gui

func update_targets():
	target = get_tree().get_first_node_in_group("player")
	gui = get_tree().get_first_node_in_group("gui")

func _ready() -> void:
	update_targets()

func _physics_process(delta):
	if !target:
		return

	var target_xform = target.global_transform.translated_local(_offset)
	global_transform = global_transform.interpolate_with(target_xform, lerp_speed * delta)
	
	look_at(target.global_position)


func _on_world_level_change() -> void:
	update_targets()
