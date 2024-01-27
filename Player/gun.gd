extends Node2D

var bullet = preload("res://Player/bullet.tscn")

@onready var sprite = $Sprite2D
@onready var point = $Marker2D

func _process(delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	if (rotation_degrees < -90 and rotation_degrees > -270) or (rotation_degrees > 90 and rotation_degrees < 270):
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	
	if rotation_degrees >= 360:
		rotation_degrees -= 360
	if rotation_degrees <= -360:
		rotation_degrees += 360
	
	if Input.is_action_just_pressed("attack_main"):
		var new_bullet = bullet.instantiate()
		Bullet.add_child(new_bullet)
		new_bullet.global_position = point.global_position
		new_bullet.push(Vector2(700, 0).rotated(rotation))
		new_bullet.rotation = rotation
