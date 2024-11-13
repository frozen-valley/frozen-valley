extends Node

signal load_star_group(star_group_index: int)
signal set_completion(group: int, star: int)
signal all_solved()

var star_groups = [StarAngles.cassiopeia_angles, StarAngles.little_dipper_angles, StarAngles.big_dipper_angles, StarAngles.little_dipper_angles[6]]
var solved_groups = 0
var solved_stars = 0


func _on_star_picker_logic_solved_star() -> void:
	solved_stars += 1
	if solved_stars == len(star_groups[solved_groups]):
		solved_stars = 0
		solved_groups += 1
		if solved_groups == len(star_groups):
			solved_groups = 0
			all_solved.emit()
		else:
			load_star_group.emit(solved_groups)
	set_completion.emit(solved_groups, solved_stars)

func _ready() -> void:
	load_star_group.emit(solved_groups)
	set_completion.emit(solved_groups, solved_stars)
