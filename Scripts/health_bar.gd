extends Node2D

@onready var bar: Sprite2D = $Bar
@onready var parent: Node2D = $".."

@export var maxHealth: int
var currentHealth: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	bar.frame = 4;


func SetMaxHealth(amount: int):
	maxHealth = amount

func Damage(amount: int):
	currentHealth -= amount

func Heal(amount: int):
	currentHealth += amount
	if currentHealth > maxHealth: currentHealth = maxHealth
