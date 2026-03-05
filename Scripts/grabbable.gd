extends Node2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var rigid_body: Node2D = $".."
var grabbed: bool = false;
var relative_position;
var pos;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	setPosToRigidBodyPos()
	if grabbed:
		rigid_body.global_position = get_global_mouse_position() + relative_position
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Grab"):
		var size: Vector2 = collision_shape.shape.size
		var mouse: Vector2 = get_global_mouse_position()
		setPosToRigidBodyPos()
		
		if (mouse.x < pos.x + size.x / 2) and (mouse.x > pos.x - size.x / 2):
			if (mouse.y < pos.y + size.y / 2) and (mouse.y > pos.y - size.y / 2):
				print("click!");
				relative_position = pos - get_global_mouse_position() 
				grabbed = true
	if event.is_action_released("Grab"):
		grabbed = false 
		#print("unclick!");

func setPosToRigidBodyPos():
	pos = rigid_body.global_position;

func _on_button_down() -> void:
	grabbed = true
	relative_position = global_position - get_global_mouse_position()
	


func _on_button_up() -> void:
	grabbed = false
