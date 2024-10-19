extends Camera3D

signal rotated(new_horizontal_angle: float, new_vertical_angle: float)

@export var rotate_speed = 1/PI
@export var min_vertical_angle = PI/8
@export var max_vertical_angle = 3*PI/8

var horizontal_angle = 0
var vertical_angle = PI/2

var instability = 0.1

var instability_dir = Vector2.RIGHT
var instability_elapsed = 0

func _ready() -> void:
	camera_rotate(Vector2.ZERO)

func _process(delta: float) -> void:
	var h_dir = 0
	var v_dir = 0
	
	if Input.is_key_pressed(KEY_D):
		h_dir += 1
	if Input.is_key_pressed(KEY_A):
		h_dir -= 1 
	if Input.is_key_pressed(KEY_W):
		v_dir += 1
	if Input.is_key_pressed(KEY_S):
		v_dir -= 1
		
	var direction = Vector2(h_dir, v_dir).normalized() * delta * rotate_speed
	if direction.length() != 0:
		camera_rotate(direction)
	
	instability_elapsed += delta
	instability_dir = Vector2(sin(instability_elapsed*0.5), -cos(2*instability_elapsed*0.5))
	
	camera_rotate(instability_dir * instability * delta * 0.25)

func bezier_blend(t: float):
	return t * t * (3.0 - 2.0 * t)
		
func camera_rotate(direction: Vector2):
	horizontal_angle = -direction.x + horizontal_angle
	vertical_angle = clamp(direction.y + vertical_angle, min_vertical_angle, max_vertical_angle)
	rotation = Vector3(vertical_angle, horizontal_angle, 0)
	
	rotated.emit(horizontal_angle, vertical_angle)
