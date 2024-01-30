extends skill_class

var bullet = preload("res://Player/bullet.tscn")
var bullet_damage = 20
var bullet_speed = 7
var bullet_size = 0.8

var push_vector = Vector2(100, 0)

var is_ready = false
var counter = 0
var count_shoot = 0

func _ready():
	set_data({
		"name_skill" : "Shotgun",
		"type_skill" : 5,
		"image_skill" : "res://Res/effects/wave.png",
		"description_skill" : "Shoot 5 bullet 3 time"
	})

func _process(delta):
	if is_ready:
		counter += 1
		if counter >= 20:
			count_shoot += 1
			counter = 0
			shoot()
		if count_shoot == 3:
			is_ready = false
			counter = 0
			count_shoot = 0

func shoot():
	AudioManager.shoot2()
	for j in range(-30, 31, 15):
		var new_bullet = bullet.instantiate()
		Bullet.add_child(new_bullet)
		new_bullet.set_params(bullet_damage * combine_modify_skill, bullet_speed, bullet_size)
		new_bullet.global_position = get_parent().link_player.gun.point.global_position
		var rotate_player = get_parent().link_player.gun.rotation
		new_bullet.push(push_vector.rotated(rotate_player + deg_to_rad(j)))
		new_bullet.rotation = rotate_player + deg_to_rad(j)

func release():
	counter = 0
	count_shoot = 0
	is_ready = true

