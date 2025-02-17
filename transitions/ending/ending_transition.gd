extends Transition

func _ready() -> void:
	super()
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.Inputs.auto_advance.fixed_delay = 3
	get_tree().create_timer(1).timeout.connect(after_1_sec)

func after_1_sec():
	Dialogic.start("ending")
