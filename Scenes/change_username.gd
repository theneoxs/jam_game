extends Control

@onready var new_name_field = $TextureRect/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	new_name_field.text = Global.user_name

func _on_change_btn_pressed():
	Global.user_name = new_name_field.text
	queue_free()
