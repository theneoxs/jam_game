extends Node

var picture = "res://Res/effects/speed boost.png"
var time = 5
@onready var timer = $Timer

var player_speed = 0
var modify = 1

func start():
	timer.wait_time = time
	timer.start()
	player_speed = get_parent().player.SPEED * modify * 0.5
	
	get_parent().player.SPEED += player_speed

func _exit_tree():
	get_parent().player.SPEED -= player_speed

func _on_timer_timeout():
	queue_free()
