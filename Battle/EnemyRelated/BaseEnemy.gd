extends Node2D
class_name Enemy
@onready  var hp:float = 100
@export var speed:int = 100
@export var attackDelay:int = 100
@export var score:int = 100
@export var damage:int = 100
@export var baseSprite:Sprite2D
@export var additionalSprite:Sprite2D
@export var modEffect:Sprite2D
var item:Object 
var modification:Object
var enemyType
var HpBar:ProgressBar

func setParams():
	var diffMod = get_node("/root/Game/Session").diff_modificator
	hp *= diffMod
	speed *=diffMod
	attackDelay *= diffMod
	damage *=diffMod
	score = (hp + speed + attackDelay + damage) / 4
	$"HP BAR".set_max(hp)
	$"HP BAR".set_value(hp)
# Called when the node enters the scene tree for the first time.
func _ready():
	setParams()
	pass # Replace with function body.

func _init():
	var a = randi_range(0,1)
	if a == 0:
		enemyType = preload("res://Battle/EnemyRelated/RangeAttack.tscn")
	else:
		enemyType = preload("res://Battle/EnemyRelated/ShortAttack.tscn")
	add_child(enemyType.instantiate())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
	print("HIT")
	hp -= damage
	changeHPbar()
	if hp <= 0:
		death()
	
func changeHPbar():
	$"HP BAR".set_value(hp)
	
		
#TODO _mutationOnTimer():
	#pass
