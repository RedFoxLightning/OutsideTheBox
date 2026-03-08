extends Resource

class_name TaskSO


@export var task_name: String


## if true, time_to_complete_min and time_to_copmlete_max will be ignored, and the task will not end
## (unless replaced with a different task via other means)
@export var persistant: bool


## The time spent on the task is randomly chosen between time_to_complete_min and time_to_complete_max
@export var time_to_complete_min: float
## The time spent on the task is randomly chosen between time_to_complete_min and time_to_complete_max
@export var time_to_complete_max: float

## If not null, the next task chosen will be this one 
@export var task_to_follow: TaskSO
