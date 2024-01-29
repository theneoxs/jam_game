extends CharacterBody2D
class_name Player
var hp = 50
var max_hp = 100

var SPEED = 250.0
const DASH_SPEED = 800.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 0.5
var is_dashing = false
var dash_timer = 0.0
var cooldown_timer = 0.0
var is_dead = false

signal death(bool)

var dash_vector = Vector2()
@onready var anim_play = $AnimationPlayer
@onready var sprite = $Sprite2D

@onready var gun = $Gun
@onready var sword = $Sword

func _ready():
	anim_play.current_animation = "idle"
	hp = max_hp

func show_hp():
	get_parent().gui.set_max_hp_value(max_hp)
	get_parent().gui.set_hp_value(hp)

func _physics_process(delta):
	if is_dead:
		return
	
	var direction = Vector2()

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	if direction.length() != 0:
		anim_play.current_animation = "run"
	else:
		anim_play.current_animation = "idle"
	
	var len_to_mouse = get_global_mouse_position()-global_position
	
	if (len_to_mouse.x > 0):
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	# Check for cooldown
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	
	# Check for dash input and cooldown status.
	if Input.is_action_pressed("dash") and not is_dashing and cooldown_timer <= 0.0:
		collision_layer = 4
		is_dashing = true
		dash_timer = DASH_DURATION
		dash_vector.x = direction.x
		dash_vector.y = direction.y

	# Apply movement.
	if is_dashing:
		velocity = dash_vector * DASH_SPEED
		dash_timer -= delta

		# Check if dash duration is over.
		if dash_timer <= 0.0:
			collision_layer = 5
			is_dashing = false
			cooldown_timer = DASH_COOLDOWN  # Start cooldown timer after dash.

	else:
		velocity = direction * SPEED
	
	if hp <= 0:
		hp = 0
		if !is_dead:
			die()
	move_and_slide()


func die():
	collision_layer = 0
	collision_mask = 0
	hp = 0
	get_parent().gui.set_hp_value(hp)
	is_dead=true
	emit_signal("death", is_dead)
	
	
