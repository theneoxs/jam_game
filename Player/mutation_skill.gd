extends CanvasLayer

var skill_block = preload("res://skill_pict.tscn")

@onready var table_skill = $TextureRect/TextureRect8/ScrollContainer/VBoxContainer
@onready var skill_list = get_parent().skill_list

@onready var first_skill_table = $TextureRect/TextureRect3/TextureRect6
@onready var first_skill_lvl_text = $TextureRect/TextureRect3/LvlText
@onready var second_skill_table = $TextureRect/TextureRect6/TextureRect6
@onready var second_skill_lvl_text = $TextureRect/TextureRect6/LvlText

@onready var result_skill_table = $TextureRect/TextureRect4/TextureRect6
@onready var result_skill_lvl_text = $TextureRect/Label2/DmgText

var first_skill = null
var second_skill = null

func _ready():
	build_table()
	print_skill()
	clear_result()
	

func build_table():
	for i in table_skill.get_children():
		i.queue_free()
	for i in skill_list.skill_list_queue:
		var new_block = skill_block.instantiate()
		table_skill.add_child(new_block)
		new_block.set_skill(i)

func _exit_tree():
	get_tree().paused = false

func _on_exit_btn_pressed():
	queue_free()


func _on_start_btn_pressed():
	if first_skill == null or second_skill == null:
		return
	var combine_skill = skill_list.combine_skill(first_skill, second_skill)
	if combine_skill != null:
		result_skill_table.texture = load(combine_skill.image_skill)
		result_skill_lvl_text.visible = true
		result_skill_lvl_text.text = "Level skill: " + str(combine_skill.combine_modify_skill)
	first_skill = null
	second_skill = null
	print_skill()
	build_table()
	get_parent().gui.change_skill(skill_list.skill_list_queue.slice(0, 3))

func print_skill():
	if first_skill != null:
		first_skill_table.texture = load(first_skill.image_skill)
		first_skill_lvl_text.visible = true
		first_skill_lvl_text.text = "lvl: " + str(first_skill.combine_modify_skill)
	else:
		first_skill_lvl_text.visible = false
		first_skill_table.texture = null
	if second_skill != null:
		second_skill_table.texture = load(second_skill.image_skill)
		second_skill_lvl_text.visible = true
		second_skill_lvl_text.text = "lvl: " + str(second_skill.combine_modify_skill)
	else:
		second_skill_lvl_text.visible = false
		second_skill_table.texture = null

func clear_result():
	result_skill_table.texture = null
	result_skill_lvl_text.visible = false

func add_skill_to_merge(skill):
	if first_skill == skill or second_skill == skill:
		if skill_list.skill_list_queue.count(skill) <= 1:
			return
	if first_skill == null:
		first_skill = skill
	else:
		second_skill = skill
	clear_result()
	print_skill()


func _on_texture_rect_3_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if first_skill != null:
			first_skill = null
		clear_result()
		print_skill()


func _on_texture_rect_6_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if second_skill != null:
			second_skill = null
		clear_result()
		print_skill()

