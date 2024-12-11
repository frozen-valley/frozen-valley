extends Sprite3D
class_name HighlightedStar

func adjust_rotation():
	var dir := position.normalized()
	var angles = direction_to_rotation(dir)
	rotation = angles

func direction_to_rotation(direction: Vector3) -> Vector3:
	# Normalize the direction vector
	var dir = direction.normalized()
	
	# Calculate the yaw (rotation around the Y axis)
	var yaw = atan2(dir.x, dir.z)
	
	# Calculate the pitch (rotation around the X axis)
	# dir.y is the vertical component
	var pitch = atan2(-dir.y, sqrt(dir.x * dir.x + dir.z * dir.z))
	
	# Roll is typically zero unless you want the object to roll on its axis
	var roll = 0.0
	# Return as a Vector3 of Euler angles
	return Vector3(pitch, yaw, roll)
