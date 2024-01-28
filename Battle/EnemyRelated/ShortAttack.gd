extends Node2D

@onready var sprite = $Sprite2D
@onready var path_point = $Path2D/PathFollow2D

var player: Node2D = null
var is_attacked = false

var move_coef = 0
var delta_move_coef = 0.1
var damage = 10

var death = false

var can_attack = true
var attack_timer = 0.0
var attack_delay = 2.55


func _ready():
	player = get_node("/root/Game/Player")
	attack_delay -= randf_range(0.1, get_node("/root/Game/Session").diff_modificator) * 0.5
	if attack_delay < 0.1:
		attack_delay = 0.1

func _process(delta):
	if death:
		return
	
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		look_at(global_position + direction)
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
	
	if attack_timer > 0.0:
		attack_timer -= delta

	if  can_attack:
		attack()
		can_attack = false
		attack_timer = attack_delay

	if attack_timer <= 0.0:
		can_attack = true

func attack():
	move_coef = 0
	sprite.rotation_degrees = 45
	path_point.progress_ratio = 0
	is_attacked = true

func _on_area_2d_body_entered(body):
	if body.name == "Player" and is_attacked == true:
		body.hp -= damage
		body.show_hp()

func _on_player_death(bool):
	death = bool
