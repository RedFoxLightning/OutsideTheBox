extends Node2D
@onready var particle_summoner: particle_summoner_script = $ParticleSummoner
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


var is_set := false
var entity_to_die
var triggered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished() -> void:
	if is_set == false:
		is_set = true
	else:
		for i in 10:
			particle_summoner.SummonParticles()
		entity_to_die.Damage(60)
		entity_to_die.SpawnImpactParticle(false)
		animated_sprite.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !triggered and body.get_child(0) != null and body.get_child(0).get_script() == base_entity:
		animated_sprite.play("activate")
		entity_to_die = body.entity
		audio_stream_player.play()
		triggered = true


func _on_audio_stream_player_2d_finished() -> void:
	if set:
		queue_free()
