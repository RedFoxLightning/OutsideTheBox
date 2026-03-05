extends RigidBody2D
#GOOBER ^^
@onready var entity: Node2D = $BaseEntity
@onready var grabbable: Node2D = $Grabbable
var currentlyBeingGrabbed: bool
var continuouslyBeingGrabbed: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	currentlyBeingGrabbed = grabbable.grabbed
	if(!continuouslyBeingGrabbed and currentlyBeingGrabbed):
		entity.Damage(1)
	continuouslyBeingGrabbed = currentlyBeingGrabbed
