extends Node2D

@onready var gui = $GUI
@onready var camera = $Camera2D
@onready var player = $Player

@onready var session_data = $Session
@onready var skill_list = $SkillList

func _process(delta):
	camera.position = player.global_position
