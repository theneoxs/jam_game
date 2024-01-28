extends skill_class

func _ready():
	set_data({
		"name_skill" : "Speed Boost",
		"type_skill" : 3,
		"image_skill" : "res://Res/effects/speed.png",
		"description_skill" : "Increase your speed to x2"
	})

func release():
	get_parent().buff_queue.add_buff(2, combine_modify_skill)
