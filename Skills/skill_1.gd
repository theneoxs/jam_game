extends skill_class

var heal_part = preload("res://Particles/heal_particle.tscn")

func _ready():
	set_data({
		"name_skill" : "Heal",
		"type_skill" : 1,
		"image_skill" : "res://Res/skill.png",
		"description_skill" : "Healself"
	})

func release():
	var heal = heal_part.instantiate()
	heal.global_position = get_parent().link_player.global_position
	add_child(heal)
	get_parent().link_player.hp += 10
	get_parent().link_player.show_hp()
