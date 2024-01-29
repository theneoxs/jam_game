extends Node2D

var bullet = preload("res://Player/bullet.tscn")
@onready var sprite = $Sprite2D
@onready var point = $Marker2D
@onready var shot_delay = $ShotDelay
var player: Node2D = null

var bullet_damage = 7
var bullet_speed = 6
var bullet_size = 1

var can_attack = true
var attack_timer = 0.0

var attack_delay = 2.55
var death = false

var marker_pos1 = Vector2(55, -9)
var marker_pos2 = Vector2(55, -1)

var is_shot = true
var push_vector = Vector2(100, 0)

func _ready():
	player = get_node("/root/Game/Player")
	attack_delay -= randf_range(0.1, get_node("/root/Game/Session").diff_modificator) * 0.5
	if attack_delay < 0.25:
		attack_delay = 0.25

func _process(delta):
	bullet_damage = get_parent().damage
	if death:
		return

	if player != null:
		var direction = (player.global_position - global_position).normalized()
		look_at(global_position + direction)
		if (rotation_degrees < -90 and rotation_degrees > -270) or (rotation_degrees > 90 and rotation_degrees < 270):
			sprite.flip_v = true
			point.position = marker_pos2
		else:
			sprite.flip_v = false
			point.position = marker_pos1

	if attack_timer > 0.0:
		attack_timer -= delta

	if can_attack:
		_attack()
		can_attack = false
		attack_timer = attack_delay

	if attack_timer <= 0.0:
		can_attack = true

func _attack():	
	is_shot = false
	shot_delay.wait_time = attack_delay
	shot_delay.start()
	
	var new_bullet = bullet.instantiate()
	Bullet.add_child(new_bullet)
	new_bullet.set_params(bullet_damage, bullet_speed, bullet_size, self)
	new_bullet.global_position = point.global_position
	new_bullet.push(push_vector.rotated(rotation))
	new_bullet.rotation = rotation

func _on_timer_timeout():
	is_shot = true
