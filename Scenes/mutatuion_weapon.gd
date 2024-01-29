extends CanvasLayer

@onready var gun_skin = $TextureRect/TextureRect/TextureRect6
@onready var sword_skin = $TextureRect/TextureRect2/TextureRect6

@onready var choose_skin = $TextureRect/TextureRect3/TextureRect6
@onready var mutation_press = $TextureRect/StartBtn

@onready var coef_text = $TextureRect/Label2/CoefText
@onready var new_skin = $TextureRect/TextureRect4/TextureRect6

@onready var dmg_text = $TextureRect/Label2/DmgText

var choose = 0
var gun_level = 1
var sword_level = 1
var coef = 1.0

var choose_block = null
var mutation_ready = true

var damage = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	dmg_text.text = "Damage: %.2f" % damage
	mutation_press.disabled = true
	gun_skin.texture = get_parent().player.gun.sprite.texture
	sword_skin.texture = get_parent().player.sword.sprite.texture
	coef = 1 + get_parent().session_data.diff_modificator
	if coef < 1:
		coef = 1.0
	coef_text.text = "Strong/weakness coeff: %.2f" % coef

func _on_texture_rect_gui_input(event):
	if event is InputEventMouseButton and event.pressed and mutation_ready:
		mutation_press.disabled = false
		choose = 1
		choose_skin.texture = gun_skin.texture
		choose_block = get_parent().player.gun
		dmg_text.text = "Damage: %.2f" % choose_block.bullet_damage
		damage = choose_block.bullet_damage
		print("Choose 1")


func _on_texture_rect_2_gui_input(event):
	if event is InputEventMouseButton and event.pressed and mutation_ready:
		mutation_press.disabled = false
		choose = 2
		choose_skin.texture = sword_skin.texture
		choose_block = get_parent().player.sword
		dmg_text.text = "Damage: %.2f" % choose_block.damage
		damage = choose_block.damage
		print("Choose 2")

func _exit_tree():
	get_tree().paused = false

func _on_exit_btn_pressed():
	queue_free()

func _on_start_btn_pressed():
	get_parent().session_data.percent_acid = 0.0
	get_parent().gui.set_toxic_value(0.0)
	var rand_upd = randi_range(0, 100)
	if rand_upd < 40:
		choose_block.upgrade_level(1, coef)
	elif rand_upd < 50:
		choose_block.upgrade_level(-1, coef)
	mutation_press.disabled = true
	mutation_ready = false
	choose_skin.texture = null
	new_skin.texture = choose_block.sprite.texture
	if choose_block.name == "Gun":
		damage = choose_block.bullet_damage
	if choose_block.name == "Sword":
		damage = choose_block.damage
	dmg_text.text = "Damage: %.2f" % damage
