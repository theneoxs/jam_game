extends RigidBody2D

@export var damage : int = 10
@export var speed : int = 100
@export var size : int = 100
@export var isBomb : bool = false
var projectileOwner : Object
var enemy : Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	#if projectileOwner == player
	$AnimationPlayer.current_animation = "bullet"

func push(vector):
	linear_velocity = vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	_delete()
	if body.get_parent() is Enemy:
			body.get_parent().getHit(damage)


func _on_timer_timeout():
	_delete()
