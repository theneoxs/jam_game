extends skill_class

func _ready():
	set_data({
		"name_skill" : "Acid Boost",
		"type_skill" : 4,
		"image_skill" : "res://Res/icon.svg",
		"description_skill" : "Increase your acid collected to x2"
	})

func release():
	get_parent().buff_queue.add_buff(3)
