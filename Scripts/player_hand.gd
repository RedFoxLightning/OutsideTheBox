extends Node2D

var mousePosition: Vector2
const maxDistanceFromMouse: float = 50
const handStiffness: float = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mousePosition = get_global_mouse_position()
	#queue_redraw()
	
	var distanceToMousePos = get_distance_to(mousePosition)
	if distanceToMousePos > maxDistanceFromMouse:
		
		# how much % of the way to the player position is maxDistanceFromMouse from mousePosition
		var percentage = 1 - (maxDistanceFromMouse / distanceToMousePos)
		var xDist = mousePosition.x - global_position.x
		var yDist = mousePosition.y - global_position.y
		position.x += xDist * percentage
		position.y += yDist * percentage
		print(percentage)
		
	
	
	#global_position = mousePosition
	
func _physics_process(_delta: float) -> void:
	position = position + (mousePosition - global_position) / handStiffness
	pass

func _draw() -> void:
	#draw_circle(Vector2(0,0),maxDistanceFromMouse,Color.INDIAN_RED,false,2)
	pass
	
func get_distance_to(target: Vector2):
	var xDist = target.x - global_position.x
	var yDist = target.y - global_position.y
	
	var total_distance: float = sqrt((xDist * xDist) + (yDist * yDist))
	
	return total_distance
