extends TextureRect

var skill = null

func set_skill(new_skill):
	skill = new_skill
	set_pict(skill.image_skill)

func set_pict(pict):
	$TextureRect6.texture = load(pict)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_parent().press_skill(skill)
