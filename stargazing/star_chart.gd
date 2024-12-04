extends Path3D


func draw(star_angles: Array[Vector2]) -> void:
	
	for star_angle in star_angles:
		var dir = Vector3.FORWARD.rotated(Vector3.UP, star_angle.x)
		dir = dir.rotated(dir.rotated(Vector3.UP, -PI/2), star_angle.y)
		curve.add_point(dir*250)
	
