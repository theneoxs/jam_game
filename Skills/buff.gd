extends Node

var picture = "res://Res/icon.svg"
var time = 5
@onready var timer = $Timer

var bullet_damage = 0
var bullet_size = 0
var sword_damage = 0

func _ready():
	timer.wait_time = time
	timer.start()
	bullet_damage = get_parent().player_gun.bullet_damage
	bullet_size = get_parent().player_gun.bullet_size
	sword_damage = get_parent().player_sword.damage
	
	get_parent().player_gun.bullet_damage += bullet_damage
	get_parent().player_sword.damage += sword_damage
	get_parent().player_gun.bullet_size += bullet_size

func _exit_tree():
	get_parent().player_gun.bullet_damage -= bullet_damage
	get_parent().player_sword.damage -= sword_damage
	get_parent().player_gun.bullet_size -= bullet_size

func _on_timer_timeout():
	queue_free()
