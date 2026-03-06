extends Node2D

@onready var health_bar: Node2D = $HealthBar
@onready var grabbable: Node2D = $Grabbable
@onready var grabbable_collision_shape: CollisionShape2D = $Grabbable/CollisionShape2D


@export var maxHealth: int = 24
@export var healthBarHeight: float
@export var grabbableCollisionShapeSize: Vector2 = Vector2(20,20)
@export var grabbableCollisionShapeOffset: Vector2 = Vector2(0,0)
var currentHealth: int

#@export var takesDamageOnGrab: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.global_position.y = global_position.y + healthBarHeight
	health_bar.SetMaxHealth(maxHealth)
	grabbable_collision_shape.shape.size.x = grabbableCollisionShapeSize.x
	grabbable_collision_shape.shape.size.y = grabbableCollisionShapeSize.y
	grabbable_collision_shape.position = grabbableCollisionShapeOffset
	grabbable.rigid_body = get_parent()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	queue_redraw()
	

func _draw() -> void:
	draw_rect(Rect2(-grabbableCollisionShapeSize.x / 2,-grabbableCollisionShapeSize.y / 2,grabbableCollisionShapeSize.x,grabbableCollisionShapeSize.y),Color.CORNFLOWER_BLUE)

func Damage(amount: int):
	health_bar.Damage(amount)

func Heal(amount: int):
	health_bar.Heal(amount)
