extends Node

var link_player = null

var skill_list_queue = []

@onready var buff_queue = get_parent().get_node("BuffQueue")

@onready var common_skills = [$Skill1, $Skill2, $Skill3, $Skill4]
@onready var rare_skills = [$Skill5]

func _ready():
	randomize()
	skill_list_queue.append($Skill5)
	skill_list_queue.append($Skill1)
	skill_list_queue.append($Skill2)
	skill_list_queue.append($Skill3)
	skill_list_queue.append($Skill4)

func get_new_skill():
	var chance_drop = randi_range(0, 100)
	var new_skill = null
	if chance_drop > 60:
		var chance_rare_drop = randi_range(0, 10)
		if chance_rare_drop >= 7:
			new_skill = rare_skills[randi_range(0, len(rare_skills)-1)]
		elif chance_rare_drop >= 3:
			new_skill = common_skills[randi_range(0, len(common_skills)-1)]
		else:
			new_skill = common_skills[0]
		add_skill(new_skill)
		get_parent().gui.change_skill(skill_list_queue.slice(0, 3))
		return skill_list_queue[-1]

func _process(delta):
	if Input.is_action_just_pressed("skill_pressed"):
		if len(skill_list_queue) > 0:
			release_first_skill().release()
			get_parent().gui.change_skill(skill_list_queue.slice(0, 3))

#Добавляет скилл в очередь
func add_skill(skill : skill_class):
	skill_list_queue.append(skill)

#Вытаскивает первый скилл и удаляет его
func release_first_skill():
	return get_skill(0, true)

#Возвращает скилл в очереди по его номеру
func get_skill(index : int, is_pop : bool = false):
	var skill = null
	if len(skill_list_queue) > 0:
		skill = skill_list_queue[index]
		if is_pop:
			skill_list_queue.pop_at(index)
	return skill

func remove_skill(skill):
	skill_list_queue.pop_at(skill_list_queue.find(skill))

#Добавляет скилл в очередь по номеру
func add_skill_to_pos(skill : skill_class, index : int):
	skill_list_queue.insert(index, skill)

#Комбинирует два скилла. Вернет:
#20% - улучшенный 1 скиил;
#20% - улучшенный 2 скилл;
#20% - новый скилл;
#15% - заниженный 1 скилл;
#15% - заниженный 2 скилл;
#10% - ничего.
func combine_skill(skill1 : skill_class, skill2 : skill_class):
	var rand_int = int(randi_range(0, 100))
	if rand_int < 20:
		remove_skill(skill2)
		return modify_skill(skill1, 1)
	
	if rand_int >= 20 and rand_int < 40:
		remove_skill(skill1)
		return modify_skill(skill2, 1)
	
	if rand_int >= 40 and rand_int < 60:
		var new_skill = get_new_skill()
		remove_skill(skill2)
		remove_skill(skill1)
		if new_skill != null:
			return modify_skill(new_skill, 1)
		return null
	
	if rand_int >= 60 and rand_int < 75:
		remove_skill(skill2)
		return modify_skill(skill1, -1)
		
	if rand_int >= 75 and rand_int < 90:
		remove_skill(skill1)
		return modify_skill(skill2, -1)
	
	remove_skill(skill2)
	remove_skill(skill1)
	return null

#Вносит модификацию в скилл и возвращает его
func modify_skill(skill, mode):
	skill.modify_combine(mode)
	return skill
