extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var closed := false

var gameManager: game_manager

func _ready() -> void:
	gameManager = get_tree().get_first_node_in_group("GameManager")

func _physics_process(_delta: float) -> void:
	if gameManager.isCurrentRoomClear():
		if closed:
			open()
	else:
		if !closed:
			close()





func open():
	animation_player.play("open")
	closed = false
func close():
	animation_player.play("close")
	closed = true
