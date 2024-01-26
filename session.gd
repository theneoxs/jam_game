extends Node

var user_score = 0
var percent_acid = 0.0
var timer = 0
var wave = 0
var diff_modificator = 0

func _process(delta):
	timer += delta
	diff_modificator = log(timer) + (wave * 0.1)

func increace_score(value):
	user_score += value
	percent_acid += log(value)*3
	if percent_acid >= 100:
		percent_acid = 100.0

func new_wave(inc = 1):
	wave += inc

func save_score():
	Net.update_data(Global.user_name, user_score)
