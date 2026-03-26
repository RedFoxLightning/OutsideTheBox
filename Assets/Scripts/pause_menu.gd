class_name pause_menu
extends Node2D
var paused = false
enum paused_screen{unpaused, paused, info}
var current_screen := paused_screen.unpaused
@export var mainPauseMenu: Node2D
@export var pauseMenuLabel: Node3D
@export var infoScreen: Node2D
@export var infoScreenBG: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hideEverything()

func hideEverything():
	mainPauseMenu.hide()
	pauseMenuLabel.hide()
	
	infoScreen.hide()
	infoScreenBG.hide()







## current_screen = paused; paused = true
func openPauseMenu():
	hideEverything()
	current_screen = paused_screen.paused
	mainPauseMenu.show()
	pauseMenuLabel.show()
	
	pause()

## current_screen = unpaused; paused = false
func closePauseMenu():
	hideEverything()
	current_screen = paused_screen.unpaused
	unpause()

## current_screen = info; paused = true
func openInfoScreen():
	hideEverything()
	current_screen = paused_screen.info
	infoScreen.show()
	infoScreenBG.show()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"): backOut(); 

func backOut():
	match current_screen:
		paused_screen.unpaused:
			openPauseMenu()
		paused_screen.paused:
			closePauseMenu()
		paused_screen.info:
			openPauseMenu()




func quit():
	print("quiting out!")
	get_tree().quit()

#func showInfoScreen():





func _on_resume_button_button_up() -> void:
	closePauseMenu()


func _on_quit_button_button_up() -> void:
	quit()
	

func _on_information_button_button_up() -> void:
	openInfoScreen()

func _on_info_screen_back_button_button_up() -> void:
	openPauseMenu()



## purely for timescale purposes, doesn't toggle any menus
func pause():
	paused = true;
	Engine.time_scale = 0;

## purely for timescale purposes, doesn't toggle any menus
func unpause():
	paused = false;
	Engine.time_scale = 1;
