extends Node

var buff_list = {
	1 : preload("res://Skills/buff.tscn"),
	2 : preload("res://Skills/speed_buff.tscn")
	}

@onready var player = get_parent().get_node("Player")
@onready var player_gun = get_parent().get_node("Player/Gun")
@onready var player_sword = get_parent().get_node("Player/Sword")

func add_buff(num):
	var new_buff = buff_list[num].instantiate()
	add_child(new_buff)
	get_parent().gui.create_buff(new_buff.name, new_buff.picture, new_buff.time)
