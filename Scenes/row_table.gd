extends HBoxContainer

@onready var num_pos_text = $Position/Label
@onready var name_text = $Name/Label
@onready var score_text = $Score/Label

func set_data(data):
	num_pos_text.text = data["num"]
	name_text.text = data["name"]
	score_text.text = data["score"]
