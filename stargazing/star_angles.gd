extends Node
class_name StarAngles

class StarAngle:
	func _init(x, y) -> void:
		self.x = x
		self.y = y

static var little_dipper_angles = [
	StarAngle.new(1.270, 0.743),
	StarAngle.new(1.399, 0.851),
	StarAngle.new(1.563, 0.623),
	StarAngle.new(1.749, 0.682),
	StarAngle.new(1.991, 0.646),
	StarAngle.new(2.214, 0.625),
	StarAngle.new(2.442, 0.508)
]

static var big_dipper_angles = [
	StarAngle.new(2.981, 0.420),
	StarAngle.new(2.954, 0.494),
	StarAngle.new(3.225, 0.468),
	StarAngle.new(3.170, 0.524),
	StarAngle.new(3.360, 0.587),
	StarAngle.new(3.423, 0.693),
	StarAngle.new(3.444, 0.778)
]

static var cassiopeia_angles = [
	StarAngle.new(4.565, 0.877),
	StarAngle.new(4.787, 0.882),
	StarAngle.new(4.718, 0.994),
	StarAngle.new(4.839, 1.046),
	StarAngle.new(4.796, 1.162)
]
