extends Node

signal load_star_group(star_group_index: int)
signal set_completion(group: int, star: int)
signal all_solved()

var solved_groups: int = 0
var solved_stars: int = 0


func _on_star_picker_logic_solved_star(_star: Vector2) -> void:
	solved_stars += 1
	if solved_stars == len(StarAngles.groups[solved_groups]):
		solved_stars = 0
		solved_groups += 1
		if solved_groups == len(StarAngles.groups):
			all_solved.emit()
		else:
			load_star_group.emit(solved_groups)
	set_completion.emit(solved_groups, solved_stars)

func _ready() -> void:
	load_star_group.emit(solved_groups)
	set_completion.emit(solved_groups, solved_stars)
