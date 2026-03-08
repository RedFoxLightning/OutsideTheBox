extends Node2D

signal new_task

var current_task_time_to_spend: float
var current_task_time_elapsed: float = 0
var current_task_persistant: bool = true

## Replaces the current state whenever it is null, not reccomended to replace
@export var voidState: TasksStateSO

var currentState: TasksStateSO
var currentTask: TaskSO


## if the current state works on an interval timer, this timer is used to make that work
@onready var tasks_interval_timer: Timer = $interval_between_tasks

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ForceStateAndTaskToNotBeNull()
	pass
	#currentState = init_state
	#currentTask = currentState.tasks[0]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ForceStateAndTaskToNotBeNull()
	
	
	if !current_task_persistant:
		
		current_task_time_elapsed += delta
		
		if current_task_time_elapsed >= current_task_time_to_spend:
			
			currentTask = currentTask.task_to_follow


func _on_interval_between_tasks_timeout() -> void:
	ForceStateAndTaskToNotBeNull()
	
	if currentState.interval_between_tasks > 0:
		getNewAction(currentState)
	


func getNewAction(from_state: TasksStateSO):
	ForceStateAndTaskToNotBeNull()
	current_task_time_elapsed = 0
	
	var new_action = TaskSO
	
	if currentTask != null and currentTask.task_to_follow != null:
		new_action = currentTask.task_to_follow
	else:
		#print("choosing action randomly from " + currentState.name + "!")
		new_action = from_state.tasks[randi_range(0,from_state.tasks.size() - 1)]
		currentTask = new_action
		#print(new_action.task_name)
	emit_signal("new_task",new_action.task_name)
	
	if !new_action.persistant:
		current_task_persistant = false
		current_task_time_to_spend = randf_range(new_action.time_to_complete_min,new_action.time_to_complete_max)
	else:
		current_task_persistant = true
		
	ResetTasksIntervalTimer()
	return new_task
	
func SetState(new_state):
	currentState = new_state
	#getNewAction(currentState)
	ResetTasksIntervalTimer()


func ResetTasksIntervalTimer():
	ForceStateAndTaskToNotBeNull()
	if currentState.interval_between_tasks > 0:
		tasks_interval_timer.start(currentState.interval_between_tasks)

func ForceStateAndTaskToNotBeNull():
	if currentState == null: currentState = voidState
	if currentTask == null: currentTask = voidState.tasks[0]
