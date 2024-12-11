extends Node2D

signal level_solved


func _on_cross_river_button_pressed() -> void:
	level_solved.emit()
