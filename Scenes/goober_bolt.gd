extends StaticBody2D
@export var flySpeed: float = 200
@export var orbitDistance: float = 50
@export var orbitSpeed: float = 8

var flying = false
var movementDirection: float
var timeAlive: float = 0
var originalPos: Vector2
@onready var animator: AnimatedSprite2D = $Animator
@onready var timer: Timer = $ActivationTimer
@onready var particle_summoner: Node2D = $ParticleSummoner



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("spawn")
	originalPos = position
	position.y = position.y - orbitDistance;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	# Handle movement
	if !flying: # if not flying, is orbiting 
		position.x = originalPos.x + sin(timeAlive * orbitSpeed) * orbitDistance
		position.y = originalPos.y + -cos(timeAlive * orbitSpeed) * orbitDistance
	if flying:
		move_local_x(flySpeed * delta)
	
	
	particle_summoner.SummonParticles()
	
	
	timeAlive += delta




func _on_activation_timer_timeout() -> void:
	
	# Despawn if been flying for too long
	timer.start(5)
	if flying: queue_free()
	
	# Shoot out in random direction if not flying yet
	flying = true
	movementDirection = randf_range(0,360)
	rotation = movementDirection # Delta set to 1 temporarily cuz idk what I'm doing
	animator.play("flying")
	


func _on_animator_animation_finished() -> void: # garunteed to be the spawn animation, as it doesn't loop
	animator.play("idle")
