extends Node2D
class_name Enemy

@export var hp:float = 100
@export var speed:int = 100
@export var attackDelay:int = 100
@export var score:int = 100
@export var damage:int = 100
@export var baseSprite:Sprite2D
@export var additionalSprite:Sprite2D
@export var modEffect:Sprite2D
var item:Object 
var modification:Object
var enemyType:Object
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

	pass # Replace with function body.

func _init():
	#var a = randi_range(0,1)
	#if a == 0:
		#var enemyType = preload("res://Battle/EnemyRelated/RangeAttack.tscn")
		#add_child(enemyType)
	#else:
		#var enemyType = preload("res://Battle/EnemyRelated/ShortAttack.tscn")
		#add_child(enemyType)

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	pass
	
func death():
	get_node("/root/Game/Session").increace_score(score)
	
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
