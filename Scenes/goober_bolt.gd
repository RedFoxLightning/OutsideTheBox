extends StaticBody2D
var flying = false
var movementDirection: float
@onready var animator: AnimatedSprite2D = $Animator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("spawn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_toward(0,100,delta)



func _on_activation_timer_timeout() -> void:
	flying = true
	movementDirection = randf_range(0,360)
	animator.play("flying")


func _on_animator_animation_finished() -> void: # garunteed to be the spawn animation, as it doesn't loop
	animator.play("idle")
