extends Node2D

var bullet = preload("res://Player/bullet.tscn")
@onready var sprite = $Sprite2D
@onready var point = $Marker2D
var player: Node2D = null
var death = false

# Новая переменная для управления задержкой между выстрелами
var can_attack = true
const attack_cooldown = 0.5
var attack_timer = 0.0

func _ready():
	player = get_node("/root/Game/Player")

func _process(delta):
	if death:
		return

	if player != null:
		var direction = (player.global_position - global_position).normalized()
		look_at(global_position + direction)  # Поворачиваем sprite в сторону Player

	# Уменьшаем таймер для задержки между выстрелами
	if attack_timer > 0.0:
		attack_timer -= delta

	# Проверяем, можно ли атаковать
	if  can_attack:
		_attack()  # Вызываем функцию атаки
		can_attack = false  # Запрещаем атаковать
		attack_timer = attack_cooldown  # Устанавливаем задержку между выстрелами

	# Проверяем, прошла ли задержка между выстрелами
	if attack_timer <= 0.0:
		can_attack = true  # Разрешаем атаковать

func _attack():
	var new_bullet = bullet.instantiate()
	Bullet.add_child(new_bullet)
	print(point.global_position)
	new_bullet.global_position = point.global_position
	new_bullet.push(Vector2(700, 0).rotated(rotation))
	new_bullet.rotation = rotation
