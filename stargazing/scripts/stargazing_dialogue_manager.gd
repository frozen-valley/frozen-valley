extends Node

signal intro_dialogue_ended()
signal explanation_dialogue_ended()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(handle_signal)
	Dialogic.start("stargazing_intro")

func handle_signal(arg: String):
	if arg == "stargazing intro ended":
		intro_dialogue_ended.emit()
	if arg == "stargazing explanation ended":
		explanation_dialogue_ended.emit()
		Dialogic.start("stargazing_cassiopeia")


func _on_stargazer_perspective_cinematic_movement_ended() -> void:
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.start("stargazing_explanation")


func _on_stargazing_tutorial_load_star_group(star_group_index: int) -> void:
	if star_group_index == 1:
		Dialogic.start("cassiopeia_solved")
	if star_group_index == 2:
		Dialogic.start("little_dipper_solved")
	if star_group_index == 3:
		Dialogic.start("big_dipper_solved")
