class_name game_manager
extends Node2D

## Enemies = entities that count toward the room being cleared (does not clear when enemies die)
@export var enemies: Array[Node2D]
## Enemies = entities that count toward the room being cleared
@export var enemyCount: int

@export var rooms_handler: Node2D

## for specifically the ultimate boundries
@export var horizontal_boundries: Array[CollisionShape2D]
## for specifically the ultimate boundries
@export var vertical_boundries: Array[CollisionShape2D]

@export var pauseMenu: pause_menu

var cleared: bool

func _physics_process(_delta: float) -> void:
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
	
	if enemyCount == 0:
		MarkRoomAsClear(rooms_handler.currently_in_room)
		MarkRoomAsClean(rooms_handler.currently_in_room)
		MarkRoomAsClean(rooms_handler.currently_in_room + Vector2.RIGHT)
		MarkRoomAsClean(rooms_handler.currently_in_room + Vector2.LEFT)
	


func isPaused() -> bool:
	return pauseMenu.paused

func isCurrentRoomClear():
	return rooms_handler.cleared_rooms.get(rooms_handler.currently_in_room)


func MarkRoomAsClear(pos: Vector2):
	rooms_handler.ClearRoom(pos)

func MarkRoomAsClean(pos: Vector2):
	rooms_handler.CleanRoom(pos)
