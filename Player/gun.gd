extends Node2D

var bullet = preload("res://Player/bullet.tscn")
var bullet_damage = 15
var bullet_speed = 7
var bullet_size = 1

var level_pict = {
	1 : preload("res://Player/gun1.tres"),
	2 : preload("res://Player/gun2.tres"),
	3 : preload("res://Player/gun3.tres"),
	4 : preload("res://Player/gun4.tres"),
}
@onready var sprite = $Sprite2D
@onready var point = $Marker2D
@onready var shot_delay = $ShotDelay

var attack_delay = 0.15
var death = false

var marker_pos1 = Vector2(55, -9)
var marker_pos2 = Vector2(55, -1)

var is_shot = true
var push_vector = Vector2(100, 0)

var level = 1

func upgrade_level(inc, coef):
	level += inc
	if level < 1:
		level = 1
	if level > 4:
		level = 4
	sprite.texture = level_pict[level]
	if inc > 0:
		bullet_damage += bullet_damage*coef*0.25
		attack_delay -= 0.01
		if attack_delay < 0.05:
			attack_delay = 0.05
	else:
		bullet_damage -= bullet_damage*coef*0.2
		attack_delay += 0.01
		if attack_delay > 1.0:
			attack_delay = 1.0

func show_pict(val1, val2, val3, val4):
	pass

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
		AudioManager.gunshoot()
		new_bullet.set_params(bullet_damage, bullet_speed, bullet_size, get_parent())
		new_bullet.global_position = point.global_position
		new_bullet.push(push_vector.rotated(rotation))
		new_bullet.rotation = rotation

func _test(value):
	print("Received value:", value)


func _on_player_death(bool):
	death = bool


func _on_timer_timeout():
	is_shot = true
