extends Label



func _on_stargazer_perspective_camera_rotated(new_horizontal_angle: float, new_vertical_angle: float) -> void:
	text = "angle: " + str(round(new_horizontal_angle*1000)/1000) + ", " + str(round(new_vertical_angle*1000)/1000)
