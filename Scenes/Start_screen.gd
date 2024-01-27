extends Control


@onready var black_screen = $ColorRect2
@onready var logo = $ColorRect/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	black_screen.modulate.a = 1
	

func _process(delta):
	black_screen.modulate.a = lerp(black_screen.modulate.a, -0.5, delta)
	if black_screen.modulate.a <= 0:
		black_screen.modulate.a = 0
		logo.modulate.a = lerp(logo.modulate.a, -0.5, delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
