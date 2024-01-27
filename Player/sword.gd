extends Node2D

@onready var sprite = $Sprite2D

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
