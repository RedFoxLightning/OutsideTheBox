extends "res://Assets/Scripts/particle.gd"

@export var colors: Array[Color]

func _ready() -> void:
	super()
	
	var new_scale = randf_range(1,2)
	scale = Vector2(new_scale, new_scale)
	
	var random_color = Color.WHITE * ((colors[randi_range(0,colors.size() - 1)]) / randf_range(1,3))
	self_modulate = Color(random_color.r,random_color.g,random_color.g,randf_range(0,1))
	
