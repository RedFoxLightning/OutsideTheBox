extends CharacterBody2D
#GOOBER ^^
@onready var entity: Node2D = $BaseEntity
#@onready var grabbable: Node2D = $Grabbable
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gooberProjectileParticles: Node2D = $ParticleSummoner
@onready var player_hand: Node2D = %PlayerHand


@export var gooberProjectile: PackedScene


enum actions { IDLE, WALKING, GROUND_ATTACKING }
var currentAction := actions.IDLE

var currentlyBeingGrabbed: bool
var continuouslyBeingGrabbed: bool


var floating := false

var walkingSpeed: float = 100
var floatingSpeed: float = 1000
var airFrictionResistance: float = 3
var attackSpellCastTime: float = 3.5 


var currentActionTimeGoal: float
var currentActionTimeElpased: float = 0
var facingDirection: int # -1, 0, or 1



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#HandleBeingGrabbedDamage()
	SelectCorrectAnimation()
	
	currentActionTimeElpased += delta
	
	if currentActionTimeElpased > currentActionTimeGoal:
		FinishCurrentAction()
		currentAction = actions.IDLE
		
	
func _physics_process(delta: float) -> void:
	
	
	# Movement behavior based on the current action/task goober is preforming
	if !floating:
		
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
		if is_on_floor():
			if currentAction == actions.WALKING:
				velocity.x = facingDirection * walkingSpeed
			else: # (if idling)
				velocity.x = 0
		
	else:
		velocity = velocity * 0.99
		#if velocity.x < 0.01: velocity.x = 0
		#if velocity.y < 0.01: velocity.y = 0
		
		motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

		#velocity.y -= get_gravity().y * delta
		
		if currentAction == actions.WALKING:
			velocity.x += facingDirection * walkingSpeed * delta
		
		
		
	#Removes all velocy if grabbed
	if entity.grabbable.grabbed: velocity = Vector2(0,0)
	
	move_and_slide()
	
	
	if currentAction == actions.GROUND_ATTACKING:
		gooberProjectileParticles.SummonParticles()
	

func getNewAction():
	currentActionTimeElpased = 0
	if !floating:
		var randomAction = randi_range(1,3)
		match randomAction:
			1:
				startFloating()
			2:
				walkToRandomPointOnFloor()
			3:
				castDamageSpell()
	else:
		var randomAction = randi_range(1,3)
		match randomAction:
			1:
				stopFloating()
			2:
				walkToRandomPointOnFloor()
			3:
				castDamageSpell()


func startFloating():
	print("goober wants to fly!")
	floating = true;
	velocity.y -= randf_range(40, 175) #floating a little bit to floating almost off screen
	pass
func stopFloating():
	print("goober wants to decend!")
	floating = false;
	pass
func walkToRandomPointOnFloor():
	print("goober wants to walk!")
	currentActionTimeGoal = randf_range(1.5,3) # how long goober will walk for
	match randi_range(1,2):
		1:
			facingDirection = -1
		2:
			facingDirection = 1
			
	currentAction = actions.WALKING
func castDamageSpell():
	print("goober wants to cause havoc!")
	currentActionTimeGoal = attackSpellCastTime
	currentAction = actions.GROUND_ATTACKING
	pass

#func HandleBeingGrabbedDamage():
	#currentlyBeingGrabbed = grabbable.grabbed
	#if(!continuouslyBeingGrabbed and currentlyBeingGrabbed):
		#entity.Damage(1)
	#continuouslyBeingGrabbed = currentlyBeingGrabbed


#func _on_grabbable_thrown(_thrownVelocity) -> void:
	##velocity += (thrownVelocity * 20) 
	#if grabbable.grabbed:
		#var xDist = get_global_mouse_position().x - player_hand.global_position.x
		#var yDist = get_global_mouse_position().y - player_hand.global_position.y
		#velocity += Vector2(xDist * 20, yDist * 20)
		##velocity += Vector2(40,0)
		#pass




func _on_timer_timeout() -> void:
	currentAction = actions.IDLE
	getNewAction()
	timer.start(0)


func FinishCurrentAction():
	if currentAction == actions.GROUND_ATTACKING:
		var newProjectile = gooberProjectile.instantiate()
		newProjectile.position = global_position
		get_parent().add_child(newProjectile)
		


func SelectCorrectAnimation():
	if currentAction == actions.WALKING or (currentAction == actions.IDLE and floating):
		if facingDirection == -1:
			animated_sprite.play("moving_left")
		else:
			animated_sprite.play("moving_right")
	elif currentAction == actions.IDLE:
		if facingDirection == -1:
			animated_sprite.play("idle_left")
		else:
			animated_sprite.play("idle_right")
	elif currentAction == actions.GROUND_ATTACKING:
		if !floating:
			if facingDirection == -1:
				animated_sprite.play("ground_casting_left")
			else:
				animated_sprite.play("ground_casting_right")
		else:
			if facingDirection == -1:
				animated_sprite.play("air_casting_left")
			else:
				animated_sprite.play("air_casting_right")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GooberButton"):
		print("HELP! I'M SOMEHOW AT " + str(global_position))
