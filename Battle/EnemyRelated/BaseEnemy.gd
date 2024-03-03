extends CharacterBody2D
class_name Enemy
@onready var maxHp:float = 100
@onready var hp:float = 100
@export var speed:float = 100.0
@export var attackDelay:float = 2.55
@export var score:int = 100
@export var damage:int = 10
@export var baseSprite:Sprite2D
@export var additionalSprite:Sprite2D
@onready var modEffect
var item:Object 
var modification:Object
var enemyType
var isMutated:bool = false
var iSRegenerator:bool = false
var mutationvalue:float = 0
@onready var mutations:Dictionary = {"AttackUp": "res://Battle/EnemyRelated/Modif/AttackUp.tscn", 
"Regen" : "res://Battle/EnemyRelated/Modif/Regen.tscn",
"Speedster": "res://Battle/EnemyRelated/Modif/Speedster.tscn",
"Tank" : "res://Battle/EnemyRelated/Modif/Tank.tscn"}

var player: Node2D = null
var type_range = 0

func setParams():
	var diffMod = randf_range(0.1, get_node("/root/Game/Session").diff_modificator)
	if diffMod < 0.1:
		diffMod = 0.1
	hp *= diffMod*1.5
	maxHp = hp
	if type_range == 0:
		speed += 100*diffMod*0.25
		if speed > 230:
			speed = 230
	else:
		speed += speed*diffMod*0.5
		if speed > 300:
			speed = 300
	#speed *= diffMod
	attackDelay -= randf_range(0.1, diffMod)
	if attackDelay < 1.25:
		attackDelay = 1.25
	damage += damage*diffMod*0.5
	score = (hp*2 + speed + attackDelay + damage) / 4
	
	$"HP BAR".set_max(hp)
	$"HP BAR".set_value(hp)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	setParams()
	if randi() % 100 <= (10 + randf_range(0.1, get_node("/root/Game/Session").diff_modificator)):
		applyMuttation()
	player = get_node("/root/Game/Player")
	$AnimationPlayer.current_animation = "walk"

func _init():
	type_range = randi_range(0,1)
	if type_range == 0:
		enemyType = preload("res://Battle/EnemyRelated/RangeAttack.tscn").instantiate()
	else:
		enemyType = preload("res://Battle/EnemyRelated/ShortAttack.tscn").instantiate()
	add_child(enemyType)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemyType.attack_delay = attackDelay
	moveTowardsPlayer(delta)
	if iSRegenerator:
		regenerate(delta)
	if mutationvalue < 100 and !isMutated:
		mutationOnTimer(delta)
	elif mutationvalue >=100 and !isMutated:
		applyMuttation()

func regenerate(delta):
	if hp<maxHp:
		hp += delta * maxHp/5
		changeHPbar()

func moveTowardsPlayer(delta):
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		if direction.x > 0:
			$Icon2.flip_h = false
		else:
			$Icon2.flip_h = true
		var velocity = direction * speed * delta
		#$CharacterBody2D.move_and_collide(velocity)
		move_and_collide(velocity)
		#translate(velocity)

func attack():
	pass
	
func death():
	get_node("/root/Game/Session").increace_score(score)
	get_tree().call_group("Game", "_on_enemy_killed")
	dropAbbility()
	queue_free()
	
func dropAbbility():
	get_parent().get_parent().skill_list.get_new_skill()

func dropGarantAbility():
	get_parent().get_parent().skill_list.create_new_skill()

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

	
func applyMuttation():
	var mutationHappeningParticle = preload("res://Battle/EnemyRelated/Modif/MuttationHappening.tscn")
	add_child(mutationHappeningParticle.instantiate())
	var random_key = mutations.keys()[randi() % mutations.size()]
	var currentMuttation = mutations[random_key]
	match random_key:
		"AttackUp":
			damage *= 3
			speed *= 1.2
			attackDelay *= 0.5
			if attackDelay < 0.75:
				attackDelay = 0.75
		"Regen":
			iSRegenerator=true
			maxHp *= 1.5
			hp = maxHp
		"Speedster":
			speed *= 2.5
			attackDelay *= 0.5
			if speed > 400:
				speed = 400
			set_scale(Vector2(0.75, 0.75))
		"Tank":
			maxHp *= 3
			damage *= 1.5
			hp = maxHp
			speed *= 1.5
			if speed > 400:
				speed = 400
			set_scale(Vector2(1.5,1.5))
	
	modEffect = load(currentMuttation)
	add_child(modEffect.instantiate())
	score*=5
	isMutated = true
	$"Mut BAR".set_value(100)
	
func mutationOnTimer(delta):
	mutationvalue  += delta * 5
	$"Mut BAR".set_value(mutationvalue)
