extends Node2D
@export var areas: Array[AreaSO]
var rng := RandomNumberGenerator.new()
var base_state

var room_numbers: Dictionary[Vector2, int] # used for adding to the seed ^^
var latest_room_number := 0
var room_areas: Dictionary[Vector2, AreaSO]
var cleared_rooms: Dictionary[Vector2, bool]
var loaded_rooms: Dictionary[Vector2, PackedScene]

const room_size: Vector2 = Vector2(640,360)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_state = rng.state 
	#rng.seed(base_seed + 1)

	var currentPos := Vector2(0,0)
	for a in areas.size():
		for r in areas[a].lengthInRooms:
			if areas[a].rooms.size() > 0: # this actually stops a crash.. so somehow this code is dealing with something I'm not expecting it to.
				AssignNewRoomNumberAt(currentPos)
				room_areas[currentPos] = areas[a]
				GenerateRoomAt(currentPos)
				
				if !areas[a].vertical:
					currentPos.x += 1
				else:
					# Reminder, +Y is DOWN
					currentPos.y += 1 
				#print(areas[a].rooms[r])
	
	#areas[0].GetRandomRoom()
	#GenerateRoomAt(Vector2(0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#print(rng.seed)

func AssignNewRoomNumberAt(pos: Vector2):
	room_numbers[pos] = latest_room_number
	latest_room_number += 1
	 
func GenerateRoomAt(pos: Vector2):
	
	# get to the same exact same rng state wherever the room is 
	var room_number = room_numbers[pos]
	rng.state = base_state
	for i in room_number:
		rng.randi_range(0,0)
	
	
	
	var newRoom = room_areas[pos].GetRandomRoom()
	newRoom = newRoom.instantiate()
	add_child(newRoom)
	newRoom.position = pos * room_size
	
	pass
