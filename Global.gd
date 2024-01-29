extends Node

var user_name = ""
var user_high_score = 0

var data_leaderboard = null
var characters = 'abcdefghijklmnopqrstuvwxyz'

func _ready():
	var new_word = generate_word(characters, 12)
	user_name = new_word

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word

func set_user_name(new_name):
	user_name = new_name

func set_user_high_score(new_high_score):
	user_high_score = new_high_score


