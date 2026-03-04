extends Node2D
var pauseMenuOpen = false
@export var mainPauseMenu: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	closeMenu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func openMenu():
	mainPauseMenu.show()
	pauseMenuOpen = true;
	Engine.time_scale = 0;
func closeMenu():
	mainPauseMenu.hide()
	pauseMenuOpen = false;
	Engine.time_scale = 1;
func toggleMenu():
	if pauseMenuOpen: closeMenu()
	else: openMenu()
	

func quit():
	print("quiting out!")
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"): toggleMenu()



func _on_resume_button_button_up() -> void:
	closeMenu()


func _on_quit_button_button_up() -> void:
	quit()
