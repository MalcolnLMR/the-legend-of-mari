extends Node2D

signal level_change

@onready var title_gui := $"../CanvasLayer/Title"
@onready var game_gui := $"../CanvasLayer/GUI"
@onready var game_over_gui := $"../CanvasLayer/GameOver"
@onready var start_btn := $"../CanvasLayer/Title/VBoxContainer/Start"
@onready var new_game_btn := $"../CanvasLayer/GameOver/VBoxContainer/NewGame"
@onready var exit_btn := $"../CanvasLayer/Title/VBoxContainer/Exit"
@onready var exit_game_btn := $"../CanvasLayer/GameOver/VBoxContainer/Exit"

var next_level_timer := 2
var timer = 0
var is_level_done := false
var is_game_over := false

var current_level_instance: Node
var current_level_index := 0
var enemies_count := 0
var total_levels := 0
var levels := [
	preload("res://Levels/level_01.tscn"),
	preload("res://Levels/level_02.tscn"),
	preload("res://Levels/level_03.tscn")
]

func _ready() -> void:
	total_levels = levels.size()
	start_btn.pressed.connect(start_game)	
	exit_btn.pressed.connect(get_tree().quit)
	exit_game_btn.pressed.connect(get_tree().quit)
	new_game_btn.pressed.connect(start_game)
	PlayerVariables.player_death.connect(game_over)

func _process(delta: float) -> void:
	if is_level_done:
		timer += delta
		if timer >= next_level_timer:
			next_level()
			is_level_done = false
			timer = 0
	if is_game_over:
		current_level_instance.free()
		is_game_over = false

func get_enemies():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemies_count += 1
		enemy.enemy_death.connect(_on_enemy_death)

func game_over():
	title_gui.visible = false
	game_gui.visible = false
	game_over_gui.visible = true
	is_game_over = true

func start_game():
	PlayerVariables.reset_player()
	current_level_instance = levels[0].instantiate()
	title_gui.visible = false
	game_gui.visible = true
	game_over_gui.visible = false
	add_child(current_level_instance)
	enemies_count = 0
	get_enemies()
	emit_signal("level_change")

func next_level():
	current_level_index += 1
	current_level_instance.free()
	if current_level_index >= total_levels:
		game_over()
		return
	current_level_instance = levels[current_level_index].instantiate()
	add_child(current_level_instance)
	enemies_count = 0
	get_enemies()
	emit_signal("level_change")
	
func _on_enemy_death():
	enemies_count -= 1
	
	if enemies_count <= 0:
		is_level_done = true
