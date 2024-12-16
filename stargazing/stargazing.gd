extends Node3D

signal solved()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_scene"):
		solved.emit()

func _on_stargazing_tutorial_all_solved() -> void:
	solved.emit()
