extends Control

@onready var main = $SoundMain
@onready var music = $SoundMusic
@onready var sfx = $SoundSFX

func _ready():
	main.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))*100
	music.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))*100
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))*100

func _on_end_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func _on_sound_main_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value/100.0))

func _on_sound_music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value/100.0))

func _on_sound_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value/100.0))
