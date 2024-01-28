extends Node

var buff_list = {
	1 : preload("res://Skills/buff.tscn"),
	2 : preload("res://Skills/speed_buff.tscn"),
	3 : preload("res://Skills/acid_buff.tscn")
	}

@onready var player = get_parent().get_node("Player")
@onready var player_gun = get_parent().get_node("Player/Gun")
@onready var player_sword = get_parent().get_node("Player/Sword")

@onready var session = get_parent().get_node("Session")

func add_buff(num, modify = 1):
	var new_buff = buff_list[num].instantiate()
	add_child(new_buff)
	new_buff.modify = modify
	new_buff.start()
	get_parent().gui.create_buff(new_buff.name, new_buff.picture, new_buff.time)
