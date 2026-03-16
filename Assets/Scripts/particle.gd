extends AnimatedSprite2D

## how many animations there are for this particle, 
## the actual animations MUST be just the animation number they are 
@export var animation_count: int = 0




func _ready() -> void:
	var selectedAnimation = randi_range(1,animation_count)
	play(str(selectedAnimation))

func _on_animation_finished() -> void:
	queue_free()
