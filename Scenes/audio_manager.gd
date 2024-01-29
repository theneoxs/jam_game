extends Node

@onready var gun_shoot = $Effects/gun_shoot
@onready var menu_music = $menuMusic
@onready var game_music = $inGameMusic
@onready var button = $Effects/button_click
@onready var perk = $Effects/usePerk
@onready var anotherShoot = $Effects/Shoot2
@onready var steps = $Effects/step

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gunshoot():
	gun_shoot.play()
	
func inGameMusic():
	game_music.play()
	
func inGameMusicStop():
	game_music.stop()
	
func menuMusic():
	menu_music.play()
	
func menuMusicStop():
	menu_music.stop()
	
func buttonClck():
	button.play()
	
func perkUse():
	perk.play()
	
func shoot2():
	anotherShoot.play()

func step():
	steps.play()
