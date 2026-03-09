extends Node2D
#@onready var collision_shape: CollisionShape2D = $"CollisionShape2D"
@export var collision_shape: Vector2

var object_to_grab: Node2D

var grabbed: bool = false;


var relative_position;

## position of the object that's grabbable
var pos;

## This is so base_entity can control where the grabbable hitbox actually is
var hitbox_offset: Vector2;

signal thrown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if grabbed:
		object_to_grab.global_position = get_global_mouse_position() + relative_position
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Grab"):
		#var size: Vector2 = collision_shape.shape.size
		var size: Vector2 = collision_shape
		var mouse: Vector2 = get_global_mouse_position()
		pos = object_to_grab.global_position;
		
		if (mouse.x < (pos.x + hitbox_offset.x) + size.x / 2) and (mouse.x > (pos.x + hitbox_offset.x) - size.x / 2):
			if (mouse.y < (pos.y + hitbox_offset.y) + size.y / 2) and (mouse.y > (pos.y + hitbox_offset.y) - size.y / 2):
				#print("click!");
				relative_position = pos - get_global_mouse_position() 
				grabbed = true
	if event.is_action_released("Grab"):

		emit_signal("thrown")
		grabbed = false 
		#print("unclick!");
