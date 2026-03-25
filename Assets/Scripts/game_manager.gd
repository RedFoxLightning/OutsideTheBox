extends Node2D

## Entities that count toward the room being cleared
@export var enemies: Array[Node2D]

var cleared: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action("ClearEnemies") and Input.is_action_pressed("CommandModifier"):
		ClearEnemies()

func ClearEnemies():
	for enemy in enemies:
		enemy.queue_free()
	enemies.clear()
