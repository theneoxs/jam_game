extends RigidBody2D

@export var damage : int = 10
@export var speed : int = 7
@export var size : int = 1
@export var isBomb : bool = false
var projectileOwner : Object
var enemy : Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	#if projectileOwner == player
	$AnimationPlayer.current_animation = "bullet"

func set_params(dmg, spd, siz):
	damage = dmg
	speed = spd
	size = siz

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
	if body.get_parent() is Enemy:
		body.get_parent().getHit(damage)
	_delete()


func _on_timer_timeout():
	_delete()
