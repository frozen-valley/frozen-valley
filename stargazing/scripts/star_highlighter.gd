extends Node3D

@onready var highlighted_star_preload := preload("res://stargazing/sub_scenes/highlighted_star.tscn")

func _on_star_picker_logic_solved_star(star: Vector2) -> void:
	var dir := Vector3.FORWARD.rotated(Vector3.UP, star.x)
	dir = dir.rotated(dir.rotated(Vector3.UP, -PI/2), star.y)
	var new_star_highlight: HighlightedStar = highlighted_star_preload.instantiate()
	new_star_highlight.position = dir * 30
	
	new_star_highlight.adjust_rotation()
	add_child(new_star_highlight)
	
	
