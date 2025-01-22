extends Level

func _ready() -> void:
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.start("wake_up")
