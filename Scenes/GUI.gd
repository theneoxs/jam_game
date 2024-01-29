extends CanvasLayer

var buff_icon = preload("res://buff_icon.tscn")

@onready var toxic_bar = $ToxicBar
@onready var toxic_bar_text = $ToxicBar/Label
@onready var HP_bar = $HPBar
@onready var HP_bar_text = $HPBar/Label
@onready var wave_text = $TextureRect/WaveText
@onready var timer_text = $TextureRect/WaveText2
@onready var score = $CounterField/Label
@onready var button_press_toxic = $ToxicBar/ButtonPress

@onready var skill_table = $Skill/HBoxContainer
@onready var buff_table = $Buffs/HBoxContainer
@onready var button_press = $Skill/ButtonPress

var timer = 0

func set_toxic_value(value):
	#print(value)
	button_press_toxic.visible = false
	toxic_bar.value = int(value)
	toxic_bar_text.text = "{value}/{max}".format({"value" : int(value), "max" : toxic_bar.max_value})
	if value >= 100:
		button_press_toxic.visible = true

func increase_toxic_value(inc_value):
	set_toxic_value(toxic_bar.value + inc_value)

func set_hp_value(value):
	HP_bar.value = value
	HP_bar_text.text = "{value}/{max}".format({"value" : "%d" % value if value <= HP_bar.max_value else HP_bar.max_value, "max" : "%d" % HP_bar.max_value})

func increase_hp_value(inc_value):
	set_hp_value(HP_bar.value + inc_value)

func set_max_hp_value(value):
	HP_bar.max_value = value
	set_hp_value(HP_bar.value)

func _process(delta):
	timer += delta
	timer_text.text = "{mm}:{ss}".format({"mm" : "%02d" % (int(timer)/60), "ss" : "%02d" % (int(timer) % 60)})

func set_wave(num_wave, num_diff = 0):
	wave_text.text = "Wave: {wave} ({diff})".format({"wave" : num_wave, "diff" : "%.2f" % num_diff})

func set_score(value):
	score.text = str(value) + " pts"

func change_skill(skill_list):
	button_press.visible = false
	for i in range(3):
		skill_table.get_node(str(i+1)).visible = false
		if i == 0:
			skill_table.get_node(str(i+1)).visible = true
		
		skill_table.get_node(str(i+1)+"/Texture").texture = null
		
		if i < len(skill_list) and skill_list[i] != null:
			skill_table.get_node(str(i+1)).visible = true
			skill_table.get_node(str(i+1)+"/Texture").texture = load(skill_list[i]["image_skill"])
			button_press.visible = true
		

func create_buff(buff_name, icon, buff_time):
	var icon_buff = buff_icon.instantiate()
	buff_table.add_child(icon_buff)
	icon_buff.name = buff_name
	icon_buff.set_icon(icon)
	icon_buff.set_timer(buff_time)

func delete_buff(buff_name):
	buff_table.get_node(buff_name).queue_free()
