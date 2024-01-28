extends skill_class

func _ready():
	set_data({
		"name_skill" : "Damage Boost",
		"type_skill" : 2,
		"image_skill" : "res://Res/effects/attack.png",
		"description_skill" : "Increase your damage to x2"
	})

func release():
	get_parent().buff_queue.add_buff(1, combine_modify_skill)
