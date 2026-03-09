extends Node2D

signal aggroed_signal
@export var detectionRange: float

var player
var goober

var aggroed: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	goober = get_tree().get_first_node_in_group("Goober")
	pass # Replace with function body.


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
