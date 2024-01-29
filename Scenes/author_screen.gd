extends Control

@onready var point1 = $Header/Point1
@onready var point2 = $Header2/Point1
@onready var point3 = $Header3/Point1
@onready var point4 = $HBoxContainer/Header2/Point1
@onready var point5 = $HBoxContainer/Header3/Point1
@onready var point6 = $HBoxContainer/Header4/Point1
@onready var point7 = $HBoxContainer/Header4/Point1
@onready var point8 = $TextureRect/Point1
@onready var point9 = $RichTextLabel

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	$Header.modulate.a = (1-(Vector2(mouse_pos.x - point1.global_position.x, mouse_pos.y - point1.global_position.y).length())/200.0) * 0.5
	$Header2.modulate.a = (1-(Vector2(mouse_pos.x - point2.global_position.x, mouse_pos.y - point2.global_position.y).length())/200.0) * 0.5
	$Header3.modulate.a = (1-(Vector2(mouse_pos.x - point3.global_position.x, mouse_pos.y - point3.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header2.modulate.a = (1-(Vector2(mouse_pos.x - point4.global_position.x, mouse_pos.y - point4.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header3.modulate.a = (1-(Vector2(mouse_pos.x - point5.global_position.x, mouse_pos.y - point5.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header4.modulate.a = (1-(Vector2(mouse_pos.x - point6.global_position.x, mouse_pos.y - point6.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header5.modulate.a = (1-(Vector2(mouse_pos.x - point7.global_position.x, mouse_pos.y - point7.global_position.y).length())/200.0) * 0.5
	$TextureRect.modulate.a = (1-(Vector2(mouse_pos.x - point8.global_position.x, mouse_pos.y - point8.global_position.y).length())/200.0) * 0.5
	$RichTextLabel.modulate.a = (1-(Vector2(mouse_pos.x - point9.global_position.x, mouse_pos.y - point9.global_position.y).length())/200.0)

func _on_exit_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)
