extends Node2D
class_name Enemy
@onready var hp:float = 100
@export var speed:float = 100.0
@export var attackDelay:int = 100
@export var score:int = 100
@export var damage:int = 10
@export var baseSprite:Sprite2D
@export var additionalSprite:Sprite2D
@export var modEffect:Sprite2D
var item:Object 
var modification:Object
var enemyType
var HpBar:ProgressBar

var player: Node2D = null
var type_range = 0

func setParams():
	var diffMod = randf_range(0.1, get_node("/root/Game/Session").diff_modificator)
	if diffMod < 0.1:
		diffMod = 0.1
	hp *= diffMod
	if type_range == 0:
		speed = 100
	else:
		speed += speed*diffMod*0.5
		if speed > 300:
			speed = 300
	#speed *= diffMod
	#attackDelay *= diffMod
	damage += damage*diffMod*0.1
	score = (hp*2 + speed + attackDelay + damage) / 4
	$"HP BAR".set_max(hp)
	$"HP BAR".set_value(hp)
# Called when the node enters the scene tree for the first time.
func _ready():
	setParams()
	player = get_node("/root/Game/Player")

func _init():
	type_range = randi_range(0,1)
	if type_range == 0:
		enemyType = preload("res://Battle/EnemyRelated/RangeAttack.tscn")
	else:
		enemyType = preload("res://Battle/EnemyRelated/ShortAttack.tscn")
	add_child(enemyType.instantiate())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveTowardsPlayer(delta)

func moveTowardsPlayer(delta):
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		var velocity = direction * speed * delta
		translate(velocity)

func attack():
	pass
	
func death():
	get_node("/root/Game/Session").increace_score(score)
	get_tree().call_group("Game", "_on_enemy_killed")
	queue_free()
	
func dropAbbility():
	pass
	
func move():
	pass
	
func create():
	pass
	
func getHit(damage:int):
	hp -= damage
	changeHPbar()
	if hp <= 0:
		death()
	
func changeHPbar():
	$"HP BAR".set_value(hp)
	
		
#TODO _mutationOnTimer():
	#pass
