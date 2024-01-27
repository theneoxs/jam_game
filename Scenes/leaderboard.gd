extends Control

var data_row = preload("res://Scenes/row_table.tscn")

@onready var data_table = $ScrollContainer/VBoxContainer

func _ready():
	show_loader(true)
	Global.data_leaderboard = null
	if Net.session_token != "":
		Net._get_leaderboards()
	if Net.in_progress == false:
		Net._authentication_request()

func _process(delta):
	if Global.data_leaderboard != null:
		for i in data_table.get_children():
			i.queue_free()
		data_table.add_child(data_row.instantiate())
		for i in Global.data_leaderboard:
			var new_row = data_row.instantiate()
			data_table.add_child(new_row)
			new_row.set_data(i)
		Global.data_leaderboard = null
		show_loader(false)

func _on_end_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func _on_update_btn_pressed():
	Net._get_leaderboards()
	show_loader(true)

func show_loader(value):
	$Loader.visible = value
