extends GPUParticles2D

var damage = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true

func start():
	$Area2D.monitoring = true

func _on_finished():
	queue_free()


func _on_area_2d_body_exited(body):
	if body is Enemy:
		body.getHit(damage)
