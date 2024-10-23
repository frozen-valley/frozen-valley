extends GPUParticles2D
class_name Snow

var viewport_size: Vector2
var y_offset: int = 100
var x_offset: int = 100
var camera: Camera2D
var center: Vector2


func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	if (!camera):
		queue_free()
		return
	viewport_size = get_viewport().size
	center = camera.get_screen_center_position()
	visibility_rect.position = Vector2(center.x - viewport_size.x / 2, center.y - viewport_size.y / 2)
	visibility_rect.size = Vector2(viewport_size.x, viewport_size.y)
	process_material.emission_shape = ParticleProcessMaterial.EmissionShape.EMISSION_SHAPE_BOX
	process_material.emission_box_extents = Vector3(viewport_size.x / 2 + 150, 1, 1)

func _process(_delta: float) -> void:
	# Make particle visibility rectangle follow the camera
	center = camera.get_screen_center_position()
	visibility_rect.position = Vector2(center.x - viewport_size.x / 2, center.y - viewport_size.y / 2)
