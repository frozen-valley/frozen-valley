extends Path3D


func draw(star_angles: Array[Vector2]) -> void:
	if len(star_angles) == 7: # hard coded for little and big dipper
		var first_star := star_angles[3]
		var dir := Vector3.FORWARD.rotated(Vector3.UP, first_star.x)
		dir = dir.rotated(dir.rotated(Vector3.UP, -PI/2), first_star.y)
		curve.add_point(dir*250)
	for star_angle in star_angles:
		var dir := Vector3.FORWARD.rotated(Vector3.UP, star_angle.x)
		dir = dir.rotated(dir.rotated(Vector3.UP, -PI/2), star_angle.y)
		curve.add_point(dir*250)
	
