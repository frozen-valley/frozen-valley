extends Level

func _ready() -> void:
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.start("wake_up")
	Dialogic.text_signal.connect(_on_dialogic_signal)

func _on_dialogic_signal(arg: String):
	if arg == "found_sister":
		finish()
