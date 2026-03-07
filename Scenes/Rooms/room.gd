extends Node2D

var rooms_handler;
var roomCoords: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rooms_handler = get_parent()
	if !rooms_handler.cleared_rooms.get(roomCoords) == true:
		SpawnEntities()
		LockGates()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func SpawnEntities():
	pass

func LockGates():
	pass

func MarkAsCleared():
	rooms_handler.cleared_rooms[roomCoords] = true
