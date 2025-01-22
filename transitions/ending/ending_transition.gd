extends Transition

func _ready() -> void:
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.Inputs.auto_advance.fixed_delay = 3
	Dialogic.start("ending")
