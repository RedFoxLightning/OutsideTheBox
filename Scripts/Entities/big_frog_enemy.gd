extends CharacterBody2D

@onready var base_entity: Node2D = $BaseEntity
@onready var tasksAI: Node2D = $tasks_ai
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export var states: Array[TasksStateSO]


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const HOP_STRENGTH = -100

func _ready() -> void:
	
	tasksAI.SetState(states[0])

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x *= base_entity.GetGroundedFriction()
	
	move_and_slide()
	if tasksAI.currentTask.task_name == "Idle":
		pass
	elif tasksAI.currentTask.task_name == "Antsy stabs":
		pass
	elif tasksAI.currentTask.task_name == "Hop twice":
		pass


func _on_tasks_ai_new_task(a) -> void:
	if a == "Idle":
		animation_player.play("idle")
	if a == "Antsy stabs":
		animation_player.play("antsy_stabbing")
	if a == "Hop twice":
		#print("hop!")
		velocity.y = HOP_STRENGTH
	#print(a)
