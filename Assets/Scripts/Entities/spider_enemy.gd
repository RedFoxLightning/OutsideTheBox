extends CharacterBody2D
@onready var base_entity: Node2D = $BaseEntity
@onready var base_enemy: Node2D = $BaseEnemy
@onready var head_sprite: Sprite2D = $HeadSprite
@onready var legs_sprite: Sprite2D = $LegsSprite

## base rotation is for later when I add the ability to climb walls fr fr >:3
var base_rotation: float = 0

var head_rotation: float = 90

# 0 won't rotate at all, 1 will look at where it wants instantaniously
var head_rot_speed: float = 1
var head_rot_speed_idle: float = 0.125
var head_rot_speed_aggroed: float = 0.8

## for idle animation, how long before looking somewhere else?
var min_attention_span = 0.8
var max_attention_span = 4.5
var remaining_attention_span: float = 0

## for idle animation, at what angles will they passively look?
var idle_look_range: float = 80


var looking_target: float

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x *= base_entity.GetGroundedFriction()
		
	if base_enemy.aggroed:
		
		head_rot_speed = head_rot_speed_aggroed
		
		# set the looking_target to look at goober position
		var og_head_sprite_rotation = head_sprite.rotation_degrees
		head_sprite.look_at(base_enemy.goober.global_position)
		looking_target = head_sprite.rotation_degrees
		head_sprite.rotation_degrees = og_head_sprite_rotation
		
	else:
		
		head_rot_speed = head_rot_speed_idle
		
		remaining_attention_span -= delta
		if remaining_attention_span <= 0:
			remaining_attention_span = randi_range(min_attention_span,max_attention_span)
			looking_target = (base_rotation - 90) + randf_range(-idle_look_range,idle_look_range)
		
	
	head_rotation = head_rotation + (looking_target - head_rotation) * head_rot_speed
	head_sprite.rotation_degrees = head_rotation
	
	

	move_and_slide()
