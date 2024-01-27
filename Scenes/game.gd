extends Node2D

var pause_mode = preload("res://Scenes/pause.tscn")

@onready var gui = $GUI
@onready var camera = $Camera2D
@onready var player = $Player
@onready var EnemyPerWave:int = 10 

@onready var session_data = $Session
@onready var skill_list = $SkillList
@onready var spawnCooldown:int = 60
@onready var points:Node = $Player/SpawnPoints
#@onready var UserViewArea:Area2D = $Player/UserViewArea
#@onready var EnemySpawnArea:Area2D = $Player/EnemySpawnArea

var enemy = preload("res://Battle/EnemyRelated/BaseEnemy.tscn")

func _ready():
	gui.set_wave(session_data.wave, session_data.diff_modificator)
	session_data.increace_score(0)
	gui.set_max_hp_value(player.max_hp)
	gui.set_hp_value(player.hp)
	gui.change_skill(skill_list.skill_list_queue)
	#gui.set_toxic_value(session_data.percent_acid)

func _process(delta):
	camera.position = player.global_position
	if spawnCooldown != 0:
		spawnCooldown -= 1
	else:
		spawnCooldown = 60
		spawnEnemy()
	
	if Input.is_action_just_pressed("ui_cancel"):
		add_child(pause_mode.instantiate())
		get_tree().paused = true

func spawnEnemy():
	var new_enemy = enemy.instantiate()
	get_parent().add_child(new_enemy)
	new_enemy.global_position = spawnInRandomPoint(points)	
	
func spawnInRandomPoint(area:Node2D):
	var randomPoint = randi_range(0, 7)
	return area.get_child(randomPoint).global_position
	

