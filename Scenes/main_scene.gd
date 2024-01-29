extends Control

var change_username = preload("res://Scenes/change_username.tscn")

@onready var user_name_text = $UserName

func _process(delta):
	user_name_text.text = Global.user_name if Global.user_name != "" else "No username"

func _on_end_btn_pressed():
	get_tree().quit()

func _on_setting_btn_pressed():
	pass # Replace with function body.

func _on_leader_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/leaderboard.tscn")

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_change_btn_pressed():
	add_child(change_username.instantiate())


func _on_title_pressed():
	get_tree().change_scene_to_file("res://Scenes/author_screen.tscn")
