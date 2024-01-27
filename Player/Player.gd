extends CharacterBody2D

const SPEED = 250.0
const DASH_SPEED = 600.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 1.0
var is_dashing = false
var dash_timer = 0.0
var cooldown_timer = 0.0

var dash_vector = Vector2()

func _physics_process(delta):
	var direction = Vector2()

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()

	# Check for cooldown
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

	# Check for dash input and cooldown status.
	if Input.is_action_pressed("ui_accept") and not is_dashing and cooldown_timer <= 0.0:
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
			is_dashing = false
			cooldown_timer = DASH_COOLDOWN  # Start cooldown timer after dash.

	else:
		velocity = direction * SPEED
	
	move_and_slide()
