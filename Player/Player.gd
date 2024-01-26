extends CharacterBody2D

const SPEED = 300.0
const DASH_SPEED = 600.0
const DASH_DURATION = 0.2
var is_dashing = false
var dash_timer = 0.0

func _physics_process(delta):
	var direction = Vector2()  # Initialize a Vector2 to represent the movement direction.

	# Check horizontal input.
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# Check vertical input.
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Normalize the direction to ensure consistent movement speed in all directions.
	direction = direction.normalized()

	# Check for dash input.
	if Input.is_action_pressed("ui_accept") and not is_dashing:
		is_dashing = true
		dash_timer = DASH_DURATION

	# Apply movement.
	if is_dashing:
		velocity = direction * DASH_SPEED
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		velocity = direction * SPEED

	move_and_slide()
