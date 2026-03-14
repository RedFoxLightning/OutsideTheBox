extends Node3D


@export var frequency: float = 0.001
@export var horizontal_amplitute: float = 5
@export var vertical_amplitute: float = 5

var time_existed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time_existed = Time.get_ticks_msec()
	rotation_degrees.y = sin(time_existed * frequency) * horizontal_amplitute
	rotation_degrees.x = cos(time_existed * frequency) * vertical_amplitute
