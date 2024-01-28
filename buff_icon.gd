extends TextureRect

@onready var timer = $Timer

func set_icon(icon):
	texture = load(icon)

func set_timer(time):
	timer.wait_time = time
	if timer.is_stopped():
		timer.start()


func _on_timer_timeout():
	queue_free()
