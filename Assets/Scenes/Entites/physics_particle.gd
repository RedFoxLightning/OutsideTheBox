extends "res://Assets/Scripts/particle.gd"

var enertia: Vector2
@export var xBaseForce: float
@export var yBaseForce: float
@export var xRandomForce: float
@export var yRandomForce: float
@export var gravityForce: float = 0.5
## do NOT set this to 0
@export var frictionForce: float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	enertia.x = randf_range(-xRandomForce,xRandomForce)
	enertia.y = randf_range(-yRandomForce,yRandomForce)
	enertia.x += xBaseForce
	enertia.y += yBaseForce
	

func _process(_delta: float) -> void:
	translate(enertia)
	enertia /= frictionForce
	enertia.y += gravityForce

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_animation_finished() -> void:
	super()
