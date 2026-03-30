extends Node
var gameManager: game_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameManager = get_tree().get_first_node_in_group("GameManager")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func Play():
	gameManager.StartGame()


func Quit():
	get_tree().quit()


func _on_play_button_button_up() -> void:
	Play()


func _on_leave_button_button_up() -> void:
	Quit()
