extends Node2D


var creator


const flySpeed: float = 350

var time_existed: float = 0
const max_time_too_exist: float = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_existed += delta
	if time_existed > max_time_too_exist:
		queue_free()
	move_local_x(flySpeed * delta)

func SetRotation(newRotation: float):
	rotation_degrees = newRotation;


func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.get_script() != null and body.get_script() != creator:
		#print("hit something with a script :nod: " + str(body.get_script()))
		if body.entity != null and body.get_script():
			#print("WOA I HIT A LVING SOMETHING!!!!!!11! ^^")
			body.entity.Damage(5)
	if body.get_script() != creator:
		queue_free()
