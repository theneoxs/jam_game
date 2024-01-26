extends Node

var skill_list_queue = []

func _ready():
	randomize()

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
		return modify_skill(skill1, 1)
	
	if rand_int >= 20 and rand_int < 40:
		return modify_skill(skill2, 1)
	
	if rand_int >= 40 and rand_int < 60:
		return modify_skill(skill_class.new(), 0)
	
	if rand_int >= 60 and rand_int < 75:
		return modify_skill(skill1, -1)
		
	if rand_int >= 75 and rand_int < 90:
		return modify_skill(skill2, -1)
	
	return null

#Вносит модификацию в скилл и возвращает его
func modify_skill(skill, mode):
	skill.modify_combine(mode)
	return skill
