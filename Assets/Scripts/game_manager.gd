class_name game_manager
extends Node2D

## Enemies = entities that count toward the room being cleared (does not clear when enemies die)
@export var enemies: Array[Node2D]
## Enemies = entities that count toward the room being cleared
@export var enemyCount: int

@export var roomsHandler: rooms_handler
@export var goober: goober_script

## for specifically the ultimate boundries
@export var horizontal_boundries: Array[CollisionShape2D]
## for specifically the ultimate boundries
@export var vertical_boundries: Array[CollisionShape2D]

@export var pauseMenu: pause_menu

var cleared: bool

@onready var audio_stream_player: AudioStreamPlayer2D = $MusicPlayer
@export var mainMenuMusic: AudioStream
@export var windSounds: AudioStream
@export var torchFlickering: AudioStream

@export var audioClipPlayer: PackedScene

func _physics_process(_delta: float) -> void:
	
	if roomsHandler.currently_in_room == Vector2(-1,0):
		audio_stream_player.volume_db = 0
		if(audio_stream_player.stream != mainMenuMusic):
			audio_stream_player.stream = mainMenuMusic
			audio_stream_player.play()
	elif roomsHandler.currently_in_room == Vector2(0,0):
		audio_stream_player.volume_db = 0
		if(audio_stream_player.stream != windSounds):
			audio_stream_player.stream = windSounds
			audio_stream_player.play()
	else:
		audio_stream_player.volume_db = 0
		if(audio_stream_player.stream != torchFlickering):
			audio_stream_player.stream = torchFlickering
			audio_stream_player.play()
	
	CheckIfRoomIsClear()
	
	if isCurrentRoomClear():
		for i in horizontal_boundries:
			i.disabled = true
	else:
		for i in horizontal_boundries:
			i.disabled = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ClearEnemies") and Input.is_action_pressed("CommandModifier"):
		ClearEnemies()

func ClearEnemies():
	print(str(enemies))
	for enemy in enemies:
		RemoveEnemy(enemy)
	
	if enemyCount != 0: 
		printerr("/!\\ WARNING: ENEMY TRACKING NOT ENTIRELY ACCURATE; 
	 ATTEMPTED TO CLEAR ALL ENEMIES AND GOT < " + str(enemyCount) + " > ENEMIES REMAINING.")
		enemyCount = 0
	
	if !enemies.is_empty():
		printerr("/!\\ WARNING: ENEMIES ARRAY ISN'T BEING CLEARED CORRECTLY;
	 ATTEMPTED TO CLEAR ALL ENEMIES BUT THE ARRAY IS AS FOLLOWS: < " + str(enemies) + " > !")
		enemies.clear()

## Do this ONCE for every enemy (every entity that counts for the room not being cleared)
func RecognizeEnemy(enemy):
	enemies.append(enemy)
	enemyCount += 1

## Do this instead of or if need be in addition to queue_free() for all enemies (be sure you've also used RecognizeEnemy())
func RemoveEnemy(enemy):
	enemyCount -= 1
	enemies.remove_at(enemies.find(enemy))
	enemy.queue_free()
	
	CheckIfRoomIsClear()
	

func isPaused() -> bool:
	return pauseMenu.paused

func isCurrentRoomClear():
	return roomsHandler.cleared_rooms.get(roomsHandler.currently_in_room)


func MarkRoomAsClear(pos: Vector2):
	roomsHandler.ClearRoom(pos)

func MarkRoomAsClean(pos: Vector2):
	roomsHandler.CleanRoom(pos)


func StartGame():
	roomsHandler.currently_in_room = Vector2(0,0)
	roomsHandler.LoadRoomAt(Vector2(0,0))
	goober.entity.grabbable.grabbed = false
	goober.position = Vector2(-48,32)

func CheckIfRoomIsClear():
	if enemyCount == 0:
		MarkRoomAsClear(roomsHandler.currently_in_room)
		MarkRoomAsClean(roomsHandler.currently_in_room)
		MarkRoomAsClean(roomsHandler.currently_in_room + Vector2.RIGHT)
		MarkRoomAsClean(roomsHandler.currently_in_room + Vector2.LEFT)
		
	

func PlayClipAtPoint(position_of_clip: Vector2, sound: AudioStream,soundsVolume: float):
	var newPlayer = audioClipPlayer.instantiate()
	newPlayer.position = position_of_clip
	add_child(newPlayer)
	newPlayer.Play(sound, soundsVolume)
