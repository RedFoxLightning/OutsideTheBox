extends Node2D
@export var areas: Array[AreaSO]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(areas[0].GetRandomRoom())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
