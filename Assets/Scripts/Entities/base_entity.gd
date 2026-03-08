extends Node2D

@onready var health_bar: Node2D = $HealthBar
@onready var grabbable: Node2D = $Grabbable
@onready var grabbable_collision_shape: CollisionShape2D = $Grabbable/CollisionShape2D


@export var maxHealth: int = 24
@export var healthBarHeight: float
@export var grabbableCollisionShapeSize: Vector2 = Vector2(20,20)
@export var grabbableCollisionShapeOffset: Vector2 = Vector2(0,0)

## 0 = 0% of speed retained  -  1 = 100% of speed retained
@export var groundedFrictionModifier: float = -1
## 0 = 0% of speed retained  -  1 = 100% of speed retained
@export var arialFrictionModifier: float = -1

@export var takesDamageOnGrab: bool = true




var characterBody: CharacterBody2D

var currentHealth: int
const debugMode: bool = false 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	characterBody = get_parent()
	health_bar.global_position.y = global_position.y + healthBarHeight
	health_bar.SetMaxHealth(maxHealth)
	grabbable_collision_shape.shape.size.x = grabbableCollisionShapeSize.x
	grabbable_collision_shape.shape.size.y = grabbableCollisionShapeSize.y
	grabbable_collision_shape.position = grabbableCollisionShapeOffset
	grabbable.object_to_grab = get_parent()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if takesDamageOnGrab:
		HandleBeingGrabbedDamage()
	
	
	if debugMode:
		queue_redraw()
	HandleBeingGrabbedDamage()
	

func _physics_process(_delta: float) -> void:
	if characterBody != null:
		#Removes all velocy if grabbed
		if grabbable.grabbed: characterBody.velocity = Vector2(0,0)
		

	pass

func _draw() -> void:
	if debugMode:
		# Show bounding box of where you're able to grab the entity
		draw_rect(Rect2(-grabbableCollisionShapeSize.x / 2,-grabbableCollisionShapeSize.y / 2,grabbableCollisionShapeSize.x,grabbableCollisionShapeSize.y),Color.CORNFLOWER_BLUE)

func Damage(amount: int):
	health_bar.Damage(amount)

func Heal(amount: int):
	health_bar.Heal(amount)



# additional grabbing code/methods

var currentlyBeingGrabbed
var continuouslyBeingGrabbed


func HandleBeingGrabbedDamage():
	currentlyBeingGrabbed = grabbable.grabbed
	if(!continuouslyBeingGrabbed and currentlyBeingGrabbed):
		Damage(1)
	continuouslyBeingGrabbed = currentlyBeingGrabbed



func _on_grabbable_thrown() -> void:
	var player_hand: Node2D = get_tree().get_first_node_in_group("Player")
	
	if grabbable.grabbed:
		var xDist = get_global_mouse_position().x - player_hand.global_position.x
		var yDist = get_global_mouse_position().y - player_hand.global_position.y
		
		if characterBody != null:
			#print("attempting to throw!")
			
			characterBody.velocity += Vector2(xDist * 20, yDist * 20)
			pass


func GetGroundedFriction():
	return groundedFrictionModifier
func GetArialFriction():
	return arialFrictionModifier
