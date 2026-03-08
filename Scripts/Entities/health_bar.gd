extends Node2D

@onready var bar: Sprite2D = $Bar
@onready var parent: Node2D = $".."

@export var maxHealth: int = 1
var currentHealth: int
var healthEmpty: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = maxHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# bar.frame can be from 0-24, 24 = no damage taken, 0 = no health remaining
	# currently clicking goober 25 times makes the health bar finally register as full for the first time (??)
	if currentHealth > 0:
		# 24 / 23 = 1.something
		var percentageOfHealthLeft: float = (float(currentHealth) / float(maxHealth))
		#print("maxHealth:" + str(maxHealth) + 
		#", currentHealth:" + str(currentHealth) + 
		#", percentageOfHealthLeft: " + str(percentageOfHealthLeft))
		
		bar.frame = int(percentageOfHealthLeft * 24)
	else:
		bar.frame = 0;
		healthEmpty = true;


func SetMaxHealth(amount: int):
	maxHealth = amount
	currentHealth = maxHealth

func Damage(amount: int):
	currentHealth -= amount
	print("Health Bar doing damage")

func Heal(amount: int):
	currentHealth += amount
	if currentHealth > maxHealth: currentHealth = maxHealth
