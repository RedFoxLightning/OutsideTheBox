extends Node2D

@onready var health_bar: Node2D = $HealthBar

@export var maxHealth: int = 24
@export var healthBarHeight: float
var currentHealth: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.global_position.y = global_position.y + healthBarHeight
	health_bar.SetMaxHealth(maxHealth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Damage(amount: int):
	health_bar.Damage(amount)

func Heal(amount: int):
	health_bar.Heal(amount)
