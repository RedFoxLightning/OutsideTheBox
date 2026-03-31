#class_name base_enemy
extends Node2D

signal aggroed_signal
@export var detectionRange: float

var player
var goober
var gameManager: game_manager

var aggroed: bool = false
# Called when the node enters the scene tree for the first time.
var recognized: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	goober = get_tree().get_first_node_in_group("Goober")
	gameManager = get_tree().get_first_node_in_group("GameManager")
	
	if gameManager.isCurrentRoomClear():
		#gameManager.RemoveEnemy(get_parent())
		get_parent().queue_free()
	else:
		gameManager.RecognizeEnemy(get_parent())
		recognized = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if aggroed == false and get_distance_to(goober.global_position) < detectionRange:
		aggroed = true
		emit_signal("aggroed_signal")
	pass


func get_distance_to(target: Vector2):
	var xDist = target.x - global_position.x
	var yDist = target.y - global_position.y
	
	var total_distance: float = sqrt((xDist * xDist) + (yDist * yDist))
	
	return total_distance


# ty to kleonc on reddit for code for detecting when a node is abt to be deleted \/
# https://www.reddit.com/r/godot/comments/mph9jw/how_can_i_run_a_function_right_before_the_node_is/
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	if recognized:
		gameManager.RemoveEnemy(get_node("."))
