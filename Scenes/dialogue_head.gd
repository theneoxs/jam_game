extends Control

@onready var head = $Head

var rotate_head = 1.0
var max_rotate = 15

var show_text = "C'mob, buddy, i need to exxxperiment!"
@onready var text_frame = $TextField/RichTextLabel
@onready var text_field = $TextField

@onready var timer_show = $ShowDiagTimer
@onready var timer_hide = $HideDiagTimer

var show_start = false
var coef_shake = 0.7
var max_x = 140

func _ready():
	text_frame.visible = false
	text_field.visible = false
	text_field.size.x = 0

func set_data(text, timer_timer, x_size = 140):
	max_x = x_size
	show_text = text
	timer_show.wait_time = timer_timer
	timer_show.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text_field.position.x = -text_field.size.x - 20
	head.rotation_degrees += rotate_head / 4
	if head.rotation_degrees > 0:
		rotate_head += -coef_shake * delta * 2
	if head.rotation_degrees < 0:
		rotate_head += coef_shake * delta * 2
	
	if show_start == true and text_field.size.x < max_x:
		text_field.size.x += 1
	if show_start == true and text_field.size.x >= max_x:
		text_frame.visible = true
		text_frame.visible_ratio += delta
		if timer_hide.is_stopped():
			timer_hide.start()
	if show_start == false and text_field.size.x > 0:
		text_frame.visible = false
		text_field.size.x -= 1
	if show_start == false and text_field.size.x <= 0:
		text_field.visible = false


func _on_show_diag_timer_timeout():
	text_frame.text = show_text
	show_start = true
	text_frame.visible_ratio = 0
	text_field.visible = true
	text_field.size.x = 0
	

func _on_hide_diag_timer_timeout():
	show_start = false
