extends skill_class

var boom_part = preload("res://Particles/boom.tscn")

func _ready():
	set_data({
		"name_skill" : "Boom",
		"type_skill" : 6,
		"image_skill" : "res://Res/effects/bomb.png",
		"description_skill" : "Deal a radius damage to x5 from your sword's damage"
	})

func release():
	var boom = boom_part.instantiate()
	boom.global_position = get_parent().link_player.global_position
	add_child(boom)
	boom.damage = get_parent().link_player.sword.damage * 5
	boom.start()
	AudioManager.perkUse()
