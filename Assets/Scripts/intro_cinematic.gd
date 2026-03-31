extends Node2D
@export var mainScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Grab"):
		ExitCinematic()

func ExitCinematic():
			#var newMainScene = mainScene.instantiate()
			#get_tree().current_scene = newMainScene
			get_tree().change_scene_to_file("res://Assets/Scenes/MainScenes/main.tscn")
			queue_free()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	ExitCinematic()
