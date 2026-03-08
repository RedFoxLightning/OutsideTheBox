extends Resource

class_name TasksStateSO

@export var name: String = "NewState"
# Goober has two states, "grounded" and "floating"
# Big frog will have 2 states, "aggroed" and "unaggroed"

## Tasks the tasksAI can pick between when this state is active
@export var tasks: Array[TaskSO]

## If above 0, every X seconds the current task switches
@export var interval_between_tasks: float

func GetRandomTask():
	if tasks.size() != 0:
		return tasks[randi_range(0, tasks.size() - 1)]
