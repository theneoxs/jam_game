extends Node2D

@export var damage:int = 100
@export var speed:int = 100
@export var size:int = 100
@export var isBomb:bool = false
var projectileOwner:Object

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.current_animation = "bullet"

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
	pass
	
func _explosion():
	pass
	
