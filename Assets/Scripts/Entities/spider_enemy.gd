extends CharacterBody2D
@onready var entity: Node2D = $BaseEntity
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

## the time inbetween shooting webs
var fire_rate: float = 1.6
var time_since_last_shot: float

## projectile spawning location offset
var fire_from_offset: Vector2 = Vector2(0,-16)

@export var webProjectile: PackedScene


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x *= entity.GetGroundedFriction()
		
	if base_enemy.aggroed:
		
		head_rot_speed = head_rot_speed_aggroed
		
		# set the looking_target to look at goober position
		var og_head_sprite_rotation = head_sprite.rotation_degrees
		head_sprite.look_at(base_enemy.goober.global_position)
		looking_target = head_sprite.rotation_degrees
		head_sprite.rotation_degrees = og_head_sprite_rotation
		
		# handle shooting the webs
		
		time_since_last_shot += delta
		if time_since_last_shot > fire_rate:
			time_since_last_shot = 0
			print("pew pew! x3");
			var newProjectile = webProjectile.instantiate()
			newProjectile.SetRotation(head_rotation)
			newProjectile.position = position + fire_from_offset
			# I hope this doesn't mean that all spiders will be immune to this spiders webs
			# If you, future me, are having this problem, uhhmm sorry :3
			newProjectile.creator = get_script()
			get_parent().add_child(newProjectile)
		
		
	else:
		
		head_rot_speed = head_rot_speed_idle
		
		remaining_attention_span -= delta
		if remaining_attention_span <= 0:
			remaining_attention_span = randi_range(min_attention_span,max_attention_span)
			looking_target = (base_rotation - 90) + randf_range(-idle_look_range,idle_look_range)
		
	
	head_rotation = head_rotation + (looking_target - head_rotation) * head_rot_speed
	head_sprite.rotation_degrees = head_rotation
	
	

	move_and_slide()
