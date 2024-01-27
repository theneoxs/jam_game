extends Node2D

var pause_mode = preload("res://Scenes/pause.tscn")
var game_over = preload("res://Scenes/game_over.tscn")

@onready var gui = $GUI
@onready var camera = $Camera2D
@onready var player = $Player

@onready var session_data = $Session
@onready var skill_list = $SkillList

func _ready():
	skill_list.link_player = player
	gui.set_wave(session_data.wave, session_data.diff_modificator)
	session_data.increace_score(0)
	gui.set_max_hp_value(player.max_hp)
	gui.set_hp_value(player.hp)
	gui.change_skill(skill_list.skill_list_queue)
	#gui.set_toxic_value(session_data.percent_acid)

func _process(delta):
	camera.position = player.global_position
	
	if Input.is_action_just_pressed("ui_cancel"):
		add_child(pause_mode.instantiate())
		get_tree().paused = true

func game_over_mode():
	var game_over_screen = game_over.instantiate()
	add_child(game_over_screen)
	game_over_screen.get_data(session_data.user_score)
