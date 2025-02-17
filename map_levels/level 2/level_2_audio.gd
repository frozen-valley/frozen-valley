extends AudioStreamPlayer2D

@export var found_sister_audio: AudioStream

func _on_sister_found() -> void:
	stop()
	stream = found_sister_audio
	play()
