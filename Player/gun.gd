extends Node2D

var bullet = preload("res://Player/bullet.tscn")
@onready var sprite = $Sprite2D
@onready var point = $Marker2D
@onready var shot_delay = $ShotDelay

var attack_delay = 0.1
var death = false

var marker_pos1 = Vector2(55, -9)
var marker_pos2 = Vector2(55, -1)

var is_shot = true

func _process(delta):
	if death:
		return
	
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	if (rotation_degrees < -90 and rotation_degrees > -270) or (rotation_degrees > 90 and rotation_degrees < 270):
		sprite.flip_v = true
		point.position = marker_pos2
	else:
		sprite.flip_v = false
		point.position = marker_pos1
	
	if rotation_degrees >= 360:
		rotation_degrees -= 360
	if rotation_degrees <= -360:
		rotation_degrees += 360
	
	if Input.is_action_pressed("attack_main") and is_shot:
		is_shot = false
		shot_delay.wait_time = attack_delay
		shot_delay.start()
		var new_bullet = bullet.instantiate()
		Bullet.add_child(new_bullet)
		new_bullet.global_position = point.global_position
		new_bullet.push(Vector2(700, 0).rotated(rotation))
		new_bullet.rotation = rotation

func _test(value):
	print("Received value:", value)


func _on_player_death(bool):
	death = bool


func _on_timer_timeout():
	is_shot = true
