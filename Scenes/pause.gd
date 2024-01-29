extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _exit_tree():
	get_tree().paused = false


func _on_exit_btn_pressed():
	AudioManager.buttonClck()
	AudioManager.inGameMusicStop()
	AudioManager.menuMusic()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_restart_btn_pressed():
	AudioManager.buttonClck()
	AudioManager.inGameMusicStop()
	AudioManager.inGameMusic()
	for i in get_node("/root/Bullet").get_children():
		i.queue_free()
	get_tree().reload_current_scene()


func _on_resume_btn_pressed():
	AudioManager.buttonClck()
	queue_free()
