extends Node

var user_score = 0
var percent_acid = 0.0
var timer = 0
var wave = 0
var diff_modificator = 0

func _ready():
	wave = 1

func _process(delta):
	timer += delta
	diff_modificator = log(timer) + (wave * 0.1)

func increace_score(value):
	user_score += value
	if value != 0:
		percent_acid += log(value)
	if percent_acid >= 100.0:
		percent_acid = 100.0
	get_parent().gui.set_score(user_score)
	get_parent().gui.set_toxic_value(percent_acid)

func new_wave(inc = 1):
	wave += inc
	get_parent().gui.set_wave(wave, int(diff_modificator))

func save_score():
	Net.update_data(Global.user_name, user_score)
