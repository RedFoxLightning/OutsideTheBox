extends Node2D

@export var particlesToSummon: PackedScene
@export var particleSummonChancePerTick: float = 0.5
@export var maxParticleDist: float = 8



func SummonParticles():
	if randf_range(0,1) < particleSummonChancePerTick:
		var newParticle = particlesToSummon.instantiate()
		newParticle.global_position = global_position + Vector2(
			randf_range(-maxParticleDist,maxParticleDist),randf_range(-maxParticleDist,maxParticleDist))
			
		get_parent().add_sibling(newParticle)
