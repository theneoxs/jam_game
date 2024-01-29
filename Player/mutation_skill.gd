extends CanvasLayer

var skill_block = preload("res://skill_pict.tscn")

@onready var table_skill = $TextureRect/TextureRect8/ScrollContainer/VBoxContainer
@onready var skill_list = get_parent().skill_list

func _ready():
	for i in skill_list.skill_list_queue:
		var new_block = skill_block.instantiate()
		table_skill.add_child(new_block)
		new_block.set_pict(i.image_skill)


func _exit_tree():
	get_tree().paused = false

func _on_exit_btn_pressed():
	queue_free()


func _on_start_btn_pressed():
	pass # Replace with function body.
