extends Node

var picture = "res://Res/effects/attack boost.png" 
var time = 5
@onready var timer = $Timer

var bullet_damage = 0
var bullet_size = 0
var sword_damage = 0

var modify = 1

func start():
	timer.wait_time = time
	timer.start()
	bullet_damage = get_parent().player_gun.bullet_damage * modify
	bullet_size = get_parent().player_gun.bullet_size
	sword_damage = get_parent().player_sword.damage * modify
	
	get_parent().player_gun.bullet_damage += bullet_damage 
	get_parent().player_sword.damage += sword_damage 
	get_parent().player_gun.bullet_size += bullet_size 

func _exit_tree():
	get_parent().player_gun.bullet_damage -= bullet_damage
	if get_parent().player_gun.bullet_damage < 10:
		get_parent().player_gun.bullet_damage = 10
	get_parent().player_sword.damage -= sword_damage
	if get_parent().player_sword.damage < 10:
		get_parent().player_sword.damage = 10
	get_parent().player_gun.bullet_size -= bullet_size

func _on_timer_timeout():
	queue_free()
