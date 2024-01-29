extends CanvasLayer

@onready var gun_skin = $TextureRect
@onready var sword_skin = $TextureRect2

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_skin.texture = get_parent().player.gun.sprite.texture
	sword_skin.texture = get_parent().player.sword.sprite.texture



func _on_texture_rect_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Choose 1")


func _on_texture_rect_2_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Choose 2")
