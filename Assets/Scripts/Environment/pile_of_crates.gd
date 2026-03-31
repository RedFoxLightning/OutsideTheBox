extends StaticBody2D

@export var flipped: bool
@onready var sprite: Sprite2D = $PileOfCrates


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.flip_h = flipped


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
