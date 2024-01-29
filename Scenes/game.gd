extends Node2D

var pause_mode = preload("res://Scenes/pause.tscn")
var game_over = preload("res://Scenes/game_over.tscn")
var mutations = preload("res://Scenes/mutatuion_weapon.tscn")
var mutations_skill = preload("res://Player/mutation_skill.tscn")

@onready var gui = $GUI
@onready var camera = $Camera2D
@onready var player = $Player

@onready var session_data = $Session
@onready var skill_list = $SkillList

@onready var spawnCooldown:int = 60
@onready var points:Node = $Player/SpawnPoints
@onready var enemyinWave
@onready var killedinWave = 0
@onready var spawnedEnemy = 0
var enemy = preload("res://Battle/EnemyRelated/BaseEnemy.tscn")

signal enemyKilled

func _ready():
	skill_list.link_player = player
	enemyinWave = session_data.enemyPerWave
	gui.set_wave(session_data.wave, session_data.diff_modificator)
	session_data.increace_score(0)
	gui.set_max_hp_value(player.max_hp)
	gui.set_hp_value(player.hp)
	gui.change_skill(skill_list.skill_list_queue)
	#gui.set_toxic_value(session_data.percent_acid)

func updateWave():
	killedinWave = 0
	spawnedEnemy = 0
	session_data.new_wave()
	enemyinWave = session_data.enemyPerWave
	gui.set_wave(session_data.wave, session_data.diff_modificator)

func _process(delta):
	camera.position = player.global_position + (get_global_mouse_position() - player.global_position) * 0.25
	if spawnCooldown > 0:
		spawnCooldown -= 1
	else:
		spawnCooldown = 60
		spawnEnemy()
	
	if Input.is_action_just_pressed("ui_cancel"):
		add_child(pause_mode.instantiate())
		get_tree().paused = true
	
	if Input.is_action_just_pressed("open_mutation") and session_data.percent_acid >= 100:
		add_child(mutations.instantiate())
		get_tree().paused = true
	
	if Input.is_action_just_pressed("open_skill_mutation"):
		add_child(mutations_skill.instantiate())
		get_tree().paused = true

func spawnEnemy():
	if spawnedEnemy < enemyinWave:
		var new_enemy = enemy.instantiate()
		$Enemies.add_child(new_enemy)
		new_enemy.global_position = spawnInRandomPoint(points)	
		spawnedEnemy += 1
	elif killedinWave >= spawnedEnemy:
		updateWave()
	
func spawnInRandomPoint(area:Node2D):
	var randomPoint = randi_range(0, 7)
	return area.get_child(randomPoint).global_position
	

func game_over_mode():
	var game_over_screen = game_over.instantiate()
	add_child(game_over_screen)
	game_over_screen.get_data(session_data.user_score)


func _on_enemy_killed():
	killedinWave += 1 # Replace with function body.


func _on_player_death(bool):
	game_over_mode()
