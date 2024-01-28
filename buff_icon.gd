extends TextureRect

@onready var timer = $Timer
@onready var pict = $picture

func set_icon(icon):
	pict.texture = load(icon)

func set_timer(time):
	timer.wait_time = time
	if timer.is_stopped():
		timer.start()


func _on_timer_timeout():
	queue_free()
