extends Label



func _on_stargazer_perspective_camera_rotated(new_horizontal_angle: float, new_vertical_angle: float) -> void:
	text = "angle: " + str(new_horizontal_angle) + ", " + str(new_vertical_angle)
