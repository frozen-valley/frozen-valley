extends Node

signal calibrated(factor: float)
signal solved_star()

const focus_duration: float = 1

var horizontal_angle: float = 0
var vertical_angle: float = 0
var calibration: float = 0

var stars: Array = []

func _process(delta: float) -> void:
	if len(stars) == 0:
		return
	
	var min_dist: float = 1
	var chosen_star: Vector2 = stars[0]
	
	for star: Vector2 in stars:
		var dist_vector: Vector2 \
		= Vector2(angle_difference(star.x, horizontal_angle), angle_difference(star.y, vertical_angle)) 
		var dist: float = dist_vector.length()
		if dist < min_dist:
			min_dist = dist
			chosen_star = star
		
	if min_dist < 0.05:
		calibration += delta / focus_duration
	else:
		calibration -= 5*delta
	calibration = clamp(calibration, 0, 1)
	calibrated.emit(calibration)
	if calibration >= 1:
		stars.erase(chosen_star)
		solved_star.emit()


func angle_difference(angle1: float, angle2: float) -> float:
	var diff: float = fmod(( angle2 - angle1 + PI ), 2*PI) - PI
	return diff + 2*PI if diff < -PI else diff


func _on_stargazer_perspective_rotated(new_horizontal_angle: float, new_vertical_angle: float) -> void:
	horizontal_angle = new_horizontal_angle
	vertical_angle = new_vertical_angle


func _on_stargazing_tutorial_load_star_group(star_group_index: int) -> void:
	stars = []
	stars.append_array(StarAngles.groups[star_group_index])
