extends Node3D


func _on_stargazing_tutorial_load_star_group(star_group_index: int) -> void:
	if star_group_index == 1:
		$CassiopeiaStarchart.draw(StarAngles.cassiopeia_angles)
	elif star_group_index == 2:
		$LittleDipperStarchart.draw(StarAngles.little_dipper_angles)
	elif star_group_index == 3:
		$BigDipperStarchart.draw(StarAngles.big_dipper_angles)
