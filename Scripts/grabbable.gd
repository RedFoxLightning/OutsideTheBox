extends CollisionShape2D

var grabbed: bool = false;
var relative_position;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if grabbed:
		global_position = get_global_mouse_position() + relative_position
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Grab"):
		var size: Vector2 = shape.size
		var mouse: Vector2 = get_global_mouse_position()
		
		if (mouse.x < global_position.x + size.x / 2) and (mouse.x > global_position.x - size.x / 2):
			if (mouse.y < global_position.y + size.y / 2) and (mouse.y > global_position.y - size.y / 2):
				print("click!");
				relative_position = global_position - get_global_mouse_position() 
				grabbed = true
	if event.is_action_released("Grab"):
		grabbed = false 



func _on_button_down() -> void:
	grabbed = true
	relative_position = global_position - get_global_mouse_position()
	


func _on_button_up() -> void:
	grabbed = false
