extends Node2D

@onready var sprite = $Sprite2D

@onready var path_point = $Path2D/PathFollow2D
var is_attacked = false

var move_coef = 0
var delta_move_coef = 0.1
var damage = 100

var death = false

func _process(delta):
	if death:
		return
	
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
	
	if is_attacked and path_point.progress_ratio < 1:
		path_point.progress_ratio += move_coef*0.9
		if path_point.progress_ratio < 0.5:
			delta_move_coef = 0.1
		else:
			delta_move_coef = -0.1
		move_coef += delta_move_coef*0.1
		sprite.global_position = path_point.global_position
		sprite.rotation_degrees = 45 - 90 * path_point.progress_ratio
	if path_point.progress_ratio >= 0.9:
		is_attacked = false
		sprite.position = Vector2(10, 0)
		sprite.rotation_degrees = 0
	
	if Input.is_action_just_pressed("attack_alt") and !is_attacked:
		attack()

func attack():
	move_coef = 0
	sprite.rotation_degrees = 45
	path_point.progress_ratio = 0
	is_attacked = true

func _on_area_2d_body_entered(body):
	if body.get_parent() is Enemy and is_attacked == true:
			body.get_parent().getHit(damage)


func _on_player_death(bool):
	death = bool
