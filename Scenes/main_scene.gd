extends Control

func _on_end_btn_pressed():
	get_tree().quit()


func _on_setting_btn_pressed():
	pass # Replace with function body.


func _on_leader_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/leaderboard.tscn")


func _on_start_btn_pressed():
	pass # Replace with function body.
