extends CanvasLayer

@onready var toxic_bar = $ToxicBar
@onready var toxic_bar_text = $ToxicBar/Label
@onready var HP_bar = $HPBar
@onready var HP_bar_text = $HPBar/Label
@onready var wave_text = $TextureRect/WaveText
@onready var timer_text = $TextureRect/WaveText2
@onready var score = $CounterField/Label

@onready var skill_table = $Skill/HBoxContainer
@onready var buff_table = $Buffs/HBoxContainer

var timer = 0

func set_toxic_value(value):
	toxic_bar.value = value
	toxic_bar_text = "{value}/{max}".format({"value" : value, "max" : toxic_bar.max_value})

func increase_toxic_value(inc_value):
	set_toxic_value(toxic_bar.value + inc_value)

func set_hp_value(value):
	HP_bar.value = value
	HP_bar = "{value}/{max}".format({"value" : value, "max" : HP_bar.max_value})

func increase_hp_value(inc_value):
	set_hp_value(HP_bar.value + inc_value)

func set_max_hp_value(value):
	HP_bar.max_value = value
	set_hp_value(HP_bar.value)

func _process(delta):
	timer += delta
	timer_text.text = "{mm}:{ss}".format({"mm" : timer/60, "ss" : timer%60})

func set_wave(num_wave, num_diff = 0):
	wave_text.text = "Wave: {wave} ({diff})".format({"wave" : num_wave, "diff" : num_diff})

func set_score(value):
	score.text = str(value)

func change_skill(skill_list):
	for i in len(skill_list):
		skill_table.get_node(str(i+1)).visible = true
		if skill_list[i] == null and i != 0:
			skill_table.get_node(str(i+1)).visible = false
		
		skill_table.get_node(str(i+1)).texture = null
