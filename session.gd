extends Node

var user_score = 0
var percent_acid = 0.0
var timer = 0
var wave = 0
var enemyPerWave:int = 1
var diff_modificator = 0.1

var modification_acid = 1

var baseEnemyPerWave = 10

func _ready():
	wave = 1

func _process(delta):
	timer += delta
	diff_modificator = log(timer / 15) + (wave * log(timer*0.1 / 5))
	if diff_modificator < 0.1:
		diff_modificator = 0.1

func increace_score(value):
	user_score += value
	if value > 0:
		percent_acid += (log(value) * modification_acid)
	if percent_acid >= 100.0:
		percent_acid = 100.0
	get_parent().gui.set_score(user_score)
	get_parent().gui.set_toxic_value(percent_acid)

func new_wave(inc = 1):
	wave += inc
	enemyPerWave = 1 + baseEnemyPerWave * diff_modificator * 0.5
	get_parent().gui.set_wave(wave, int(diff_modificator))
	return enemyPerWave

func save_score():
	Net.update_data(Global.user_name, user_score)
