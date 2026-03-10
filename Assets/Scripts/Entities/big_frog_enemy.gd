extends CharacterBody2D

@onready var entity: Node2D = $BaseEntity
@onready var tasksAI: Node2D = $tasks_ai
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var base_enemy: Node2D = $BaseEnemy


@export var states: Array[TasksStateSO]

enum actions { IDLE, HOPPING, ANTSY_STABBING, STABBING, LEAPING, CHARGING }
var currentAction = actions.IDLE

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
const HOP_STRENGTH = -100
const LEAP_STRENGTH = -300

# -1 = goober is left, 1 = goober is right
var left_right_direction_to_goober: int = -1

func _ready() -> void:
	
	tasksAI.SetState(states[0])

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x *= entity.GetGroundedFriction()
	
	tasksAI.ForceStateAndTaskToNotBeNull()
	
	if(base_enemy.aggroed):
		var tempDirection
		var tempWillMoveTowardPlayer: bool
		if(global_position.x > base_enemy.goober.global_position.x + 50):
			tempDirection = -1
			tempWillMoveTowardPlayer = true
		elif global_position.x < base_enemy.goober.global_position.x - 50:
			tempDirection = 1
			tempWillMoveTowardPlayer = true
		else:
			tempWillMoveTowardPlayer = false
		
		if tempWillMoveTowardPlayer: velocity.x += tempDirection * 10 
	
	move_and_slide()
	if tasksAI.currentTask.task_name == "Idle":
		pass
	elif tasksAI.currentTask.task_name == "Antsy stabs":
		pass
	elif tasksAI.currentTask.task_name == "Hop twice":
		pass


func _on_tasks_ai_new_task(task) -> void:
	
	#unnagroed stuff
	
	if task == "Idle":
		animation_player.play("idle")
	elif task == "Antsy stabs":
		animation_player.play("antsy_stabbing")
	elif task == "Hop twice":
		#print("hop!")
		velocity.y = HOP_STRENGTH
	
	#aggroed stuff
	
	if task == "Charge":
		#var distanceToGooberX = global_position.x - base_enemy.goober.global_position.x
		if base_enemy.get_distance_to(base_enemy.goober.global_position) > 75:
			pass
			currentAction = actions.CHARGING
			#print("(charging :p)")
		else:
			base_enemy.goober.entity.Damage(12)
			animation_player.play("violent_stabbing")
			#print("stab stab")
		
	if task == "Leap":
		if is_on_floor():
			velocity.y = LEAP_STRENGTH
			#print("LEAPING")


func _on_base_enemy_aggroed_signal() -> void:
	tasksAI.SetState(states[1])
	#print("RAHHHHHHH")
