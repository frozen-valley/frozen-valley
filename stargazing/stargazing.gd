extends Node3D

signal solved()

func _on_stargazing_tutorial_all_solved() -> void:
	solved.emit()
