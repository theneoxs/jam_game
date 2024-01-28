extends Node

var picture = "res://Res/effects/toxic boost.png"
var time = 5
@onready var timer = $Timer

var acid_collect = 0
var modify = 1

func start():
	timer.wait_time = time
	timer.start()
	acid_collect = get_parent().session.modification_acid * modify
	
	get_parent().session.modification_acid += acid_collect

func _exit_tree():
	get_parent().session.modification_acid -= acid_collect

func _on_timer_timeout():
	queue_free()
