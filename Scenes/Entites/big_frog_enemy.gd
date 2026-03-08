extends CharacterBody2D

@onready var base_entity: Node2D = $BaseEntity

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x *= base_entity.GetGroundedFriction()
	
	move_and_slide()
