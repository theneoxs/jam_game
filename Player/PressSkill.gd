extends VBoxContainer


func press_skill(skill):
	get_parent().get_parent().get_parent().get_parent().add_skill_to_merge(skill)
