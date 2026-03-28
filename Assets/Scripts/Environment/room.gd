extends Node2D


@export var goober_enter_forward_pos: float = -250
@export var goober_enter_backward_pos: float = 250


var roomsHandler;
var roomCoords: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	roomsHandler = get_parent()
	if !roomsHandler.cleared_rooms.get(roomCoords) == true:
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
	roomsHandler.cleared_rooms[roomCoords] = true
