extends Node2D
class_name Enemy

@export var hp:int = 100
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

# Called when the node enters the scene tree for the first time.
func _ready():
	var a = randi_range(0,1)
	if a == 0:
		var enemyType = preload("res://Battle/EnemyRelated/RangeAttack.tscn")
		add_child(enemyType)
	else:
		var enemyType = preload("res://Battle/EnemyRelated/ShortAttack.tscn")
		add_child(enemyType)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _attack():
	pass
	
func _death():
	pass
	
func _dropAbbility():
	pass
	
func _move():
	pass
	
func _create():
	pass
	
#TODO _mutationOnTimer():
	#pass
