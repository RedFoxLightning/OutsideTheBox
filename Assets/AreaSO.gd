extends Resource

class_name AreaSO

@export var name: String = "newArea"
@export var vertical: bool = false
@export var lengthInRooms: int = 1
#@export var titleImage: PackedScene #using packedScene for now, not sure if I wanna use that or just an image
@export var rooms: Array[PackedScene]

func GetRandomRoom():
	var selectedRoomID = randi_range(0,rooms.size() - 1)
	return rooms[selectedRoomID]
