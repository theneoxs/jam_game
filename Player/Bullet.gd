extends RigidBody2D

@export var damage : float = 10.0
@export var speed : float = 7.0
@export var size : float = 1.0
@export var isBomb : bool = false
var projectileOwner = null
var enemy : Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.current_animation = "bullet"

func set_params(dmg, spd, siz, owner = null):
	damage = dmg
	speed = spd
	size = siz
	if owner != null:
		projectileOwner = owner
		if projectileOwner.name == "Player":
			$AnimationPlayer.current_animation = "bullet"
			collision_mask = 2
	
		if projectileOwner.name == "RangeAttack":
			$AnimationPlayer.current_animation = "bullet_enemy"
			collision_mask = 1

func push(vector):
	linear_velocity = vector * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = Vector2(1, 1) * size

func _create():
	pass
	
func _move():
	pass
	
func _hit():
	pass
	
func _delete():
	queue_free()
	
func _explosion():
	pass

func _on_body_entered(body):
	if body is Enemy:
		body.getHit(damage)
	elif body.name == "Player":
		body.hp -= damage
		body.show_hp()
	_delete()

		

func _on_timer_timeout():
	_delete()
