extends Sprite3D
class_name StargazingTree

func adjust_rotation():
	var dir := position.normalized()
	var angle := atan(dir.x/dir.z)
	rotation = Vector3(0, angle, 0)
