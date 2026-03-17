extends Node2D
@export var areas: Array[AreaSO]
var rng := RandomNumberGenerator.new()
var base_state

var room_numbers: Dictionary[Vector2, int] # used for adding to the seed ^^
var latest_room_number := 0
var room_areas: Dictionary[Vector2, AreaSO]
var cleared_rooms: Dictionary[Vector2, bool]
var loaded_rooms: Dictionary[Vector2, Node2D]
var all_rooms: Dictionary[Vector2, PackedScene]
## Has to do with wether or not there's poison
var cleaned_rooms: Dictionary[Vector2, bool]

# target pixel resolution is 640 by 360, but the screen displays a little less than that
const room_size: Vector2 = Vector2(590,360)
var goober

#room that goober and the player are currently in
var currently_in_room = Vector2(0,0)

@export var main_menu: PackedScene

@onready var poison_left: Node2D = $PoisonLeft
@onready var poison_right: Node2D = $PoisonRight
@onready var poison_up: Node2D = $PoisonUp
@onready var poison_down: Node2D = $PoisonDown



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	cleaned_rooms[Vector2(0,0)] = true
	cleaned_rooms[Vector2(-1,0)] = true
	cleaned_rooms[Vector2(-2,0)] = true
	cleaned_rooms[Vector2(1,0)] = true
	
	goober = get_tree().get_first_node_in_group("Goober")
	base_state = rng.state 
	#rng.seed(base_seed + 1)

	var currentPos := Vector2(0,0)
	for a in areas.size():
		for r in areas[a].lengthInRooms:
			if areas[a].rooms.size() > 0: # this actually stops a crash.. so somehow this code is dealing with something I'm not expecting it to.
				AssignNewRoomNumberAt(currentPos)
				room_areas[currentPos] = areas[a]
				all_rooms[currentPos] = GenerateRoomAt(currentPos)
				
				if !areas[a].vertical:
					currentPos.x += 1
				else:
					# Reminder, +Y is DOWN
					currentPos.y += 1 
				#print(areas[a].rooms[r])
	
	currently_in_room = Vector2(-1,0)
	
	#areas[0].GetRandomRoom()
	#GenerateRoomAt(Vector2(0,0))
	
	all_rooms[Vector2(-1,0)] = main_menu
	
	LoadRoomAt(currently_in_room)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if goober.position.x >= room_size.x / 2:
		currently_in_room.x += 1
		#GenerateRoomAt(currently_in_room)
		LoadRoomAt(currently_in_room)
		goober.position.x = loaded_rooms[currently_in_room].goober_enter_forward_pos
		goober.entity.grabbable.grabbed = false
	if goober.position.x <= -room_size.x / 2:
		currently_in_room.x -= 1
		#GenerateRoomAt(currently_in_room)
		LoadRoomAt(currently_in_room)
		print(loaded_rooms)
		goober.position.x = loaded_rooms[currently_in_room].goober_enter_backward_pos
		goober.entity.grabbable.grabbed = false
	pass
	
	#print(rng.seed)
	
	
	if(cleaned_rooms.get_or_add(currently_in_room + Vector2.RIGHT,false) == false):
		poison_right.SummonParticles()
	if(cleaned_rooms.get_or_add(currently_in_room + Vector2.LEFT,false) == false):
		poison_left.SummonParticles()
	#if(cleaned_rooms.get_or_add(currently_in_room + Vector2.UP,false) == false):
	#	poison_up.SummonParticles()
	#if(cleaned_rooms.get_or_add(currently_in_room + Vector2.DOWN,false) == false):
	#	poison_down.SummonParticles()
	
	

func AssignNewRoomNumberAt(pos: Vector2):
	room_numbers[pos] = latest_room_number
	latest_room_number += 1
	 
func GenerateRoomAt(pos: Vector2):
	
	print("generating new room!!!")
	
	## get to the same exact same rng state wherever the room is 
	##print(str(pos) + str(room_numbers))
	#var room_number = room_numbers.get(pos)
	#rng.state = base_state
	#
	#for i in room_number:
		#rng.randi_range(0,0)
	
	
	
	var newRoom = room_areas[pos].GetRandomRoom()
	all_rooms[pos] = newRoom
	return newRoom
	

func LoadRoomAt(pos: Vector2):
	print("loading new room!")
	# deloads any currently loaded rooms
	for i in loaded_rooms:
		loaded_rooms[i].queue_free();
	loaded_rooms.clear()
	
	
	var newRoom = all_rooms[pos]
	newRoom = newRoom.instantiate()
	loaded_rooms[pos] = newRoom

	add_child(newRoom) # new rooms use get_parent() to find this script
	#newRoom.position = pos * room_size
	
