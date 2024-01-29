extends CanvasLayer

@onready var score_text = $TextureRect/ScoreText
@onready var nickname_text = $TextureRect/NickName

func get_data(score):
	score_text.text = str(score) + " pts"
	if Global.user_name == "":
		Global.user_name = Global.generate_word(Global.characters, 12)
	nickname_text.text = Global.user_name
	Net.update_data(Global.user_name, score)
	


func _on_restart_btn_pressed():
	AudioManager.buttonClck()
	AudioManager.inGameMusicStop()
	AudioManager.inGameMusic()
	get_tree().reload_current_scene()


func _on_exit_btn_pressed():
	AudioManager.buttonClck()
	AudioManager.inGameMusicStop()
	AudioManager.menuMusic()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
