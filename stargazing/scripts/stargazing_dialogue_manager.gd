extends Node

signal intro_dialogue_ended()
signal explanation_dialogue_ended()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(handle_signal)
	Dialogic.start("stargazing_intro")

func handle_signal(arg: String):
	print(arg)
	if arg == "stargazing intro ended":
		intro_dialogue_ended.emit()
	if arg == "stargazing explanation ended":
		explanation_dialogue_ended.emit()
		Dialogic.start("stargazing_cassiopeia")


func _on_stargazer_perspective_cinematic_movement_ended() -> void:
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.start("stargazing_explanation")
