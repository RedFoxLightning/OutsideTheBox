extends AnimatedSprite2D

func _ready() -> void:
	var selectedAnimation = randi_range(1,4)
	play(str(selectedAnimation))

func _on_animation_finished() -> void:
	queue_free()
