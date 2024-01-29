class_name skill_class extends Node2D

var name_skill = ""
var type_skill = 0
var image_skill = ""
var description_skill = ""

var combine_modify_skill = 1

func _init():
	var data = {
		"name_skill" : "Test skill",
		"type_skill" : randi_range(0, 10),
		"image_skill" : "res://Res/icon.svg",
		"description_skill" : "This test skill. You do not show him"
	}
	set_data(data)

func set_data(data):
	name_skill = data["name_skill"]
	type_skill = data["type_skill"]
	image_skill = data["image_skill"]
	description_skill = data["description_skill"]

func modify_combine(mode : int):
	combine_modify_skill += mode
	if combine_modify_skill < 0:
		combine_modify_skill = 0

func release():
	return "Это пустой скилл, он ничего не делает"
