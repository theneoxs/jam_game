extends Node

var picture = "res://Res/icon.svg"
var time = 5
@onready var timer = $Timer

var player_speed = 0

func _ready():
	timer.wait_time = time
	timer.start()
	player_speed = get_parent().player.SPEED
	
	get_parent().player.SPEED += player_speed

func _exit_tree():
	get_parent().player.SPEED -= player_speed

func _on_timer_timeout():
	queue_free()
