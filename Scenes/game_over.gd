extends CanvasLayer

@onready var score_text = $TextureRect/ScoreText
@onready var nickname_text = $TextureRect/NickName

func get_data(score):
	score_text.text = str(score) + " pts"
	nickname_text.text = Global.user_name
	Net.update_data(Global.user_name, score)
	
