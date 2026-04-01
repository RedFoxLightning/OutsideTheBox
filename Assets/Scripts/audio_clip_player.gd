extends AudioStreamPlayer2D

func Play(sound: AudioStream, soundsVolume):
	stream = sound
	volume_db = soundsVolume
	play()

func _on_finished() -> void:
	queue_free()
