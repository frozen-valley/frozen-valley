extends Node

signal calibrated(factor: float)
signal solved_one()
signal solved_all()

var horizontal_angle = 0
var vertical_angle = 0
var calibration = 0
var solved = 0
var stars = StarAngles.cassiopeia_angles + StarAngles.big_dipper_angles + StarAngles.little_dipper_angles

func get_next_star():
	var star = stars[solved]
	return star
	

func _process(delta: float) -> void:
	var star = get_next_star()
	var dist_vector: Vector2 \
	= Vector2(angle_difference(star.x, horizontal_angle), angle_difference(star.y, vertical_angle)) 
	var dist = dist_vector.length()
	if dist < 0.05:
		calibration += 0.2*delta
	else:
		calibration -= delta
	calibration = clamp(calibration, 0, 1)
	calibrated.emit(calibration)
	
	if calibration >= 1:
		solved += 1
		solved_one.emit()
		if solved == stars.size():
			solved_all.emit()

func angle_difference(angle1: float, angle2: float):
	var diff = fmod(( angle2 - angle1 + PI ), 2*PI) - PI
	return diff + 2*PI if diff < -PI else diff


func _on_stargazer_perspective_rotated(new_horizontal_angle: float, new_vertical_angle: float) -> void:
	horizontal_angle = new_horizontal_angle
	vertical_angle = new_vertical_angle
