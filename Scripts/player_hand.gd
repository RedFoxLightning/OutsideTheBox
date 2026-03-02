extends Node2D

const maxDistanceFromMouse: float = 50
const handStiffness: float = 3
const panning_sensitivity: float = 3

@onready var camera: Camera2D = %Camera2D
var mousePosition: Vector2
var mousePositionLastFrame: Vector2
var positionLastFrame: Vector2
var dragging: bool
var camera_offset: Vector2
var original_camera_pos: Vector2
var camera_moved_so_far: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mousePositionLastFrame = mousePosition
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mousePosition = get_global_mouse_position()
	
	
	# Keeping within a certain distance of the mouse cursor
	var distanceToMousePos = get_distance_to(mousePosition)
	if distanceToMousePos > maxDistanceFromMouse:
		
		# how much % of the way to the player position is maxDistanceFromMouse from mousePosition
		var percentage = 1 - (maxDistanceFromMouse / distanceToMousePos)
		var xDist = mousePosition.x - global_position.x
		var yDist = mousePosition.y - global_position.y
		position.x += xDist * percentage
		position.y += yDist * percentage
			
			
	


func _physics_process(_delta: float) -> void:
	#if !dragging:
	position = position + (mousePosition - global_position) / handStiffness
	
	# Move the camera when dragging
	mousePosition = get_global_mouse_position()
	if dragging:
		
		camera_moved_so_far = camera.global_position - original_camera_pos
		var distanceToMove = ((get_global_mouse_position() - camera_moved_so_far) + camera_offset) - original_camera_pos
		camera.global_position = original_camera_pos - distanceToMove * panning_sensitivity
		
	
	mousePositionLastFrame = get_global_mouse_position()
	positionLastFrame = global_position

	pass


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Move")):
		dragging = true
		camera_offset = camera.global_position - get_global_mouse_position()
		original_camera_pos = camera.global_position
	if(event.is_action_released("Move")): dragging = false


func _draw() -> void:
	#draw_circle(Vector2(0,0),maxDistanceFromMouse,Color.INDIAN_RED,false,2)
	pass
	
func get_distance_to(target: Vector2):
	var xDist = target.x - global_position.x
	var yDist = target.y - global_position.y
	
	var total_distance: float = sqrt((xDist * xDist) + (yDist * yDist))
	
	return total_distance
