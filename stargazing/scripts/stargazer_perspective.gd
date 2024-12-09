extends Camera3D

signal rotated(new_horizontal_angle: float, new_vertical_angle: float)

@export var starting_horizontal_angle: float = 0
@export var starting_vertical_angle: float = PI/8
@export var rotate_speed: float = 1/PI
@export var min_vertical_angle: float = PI/8
@export var max_vertical_angle: float = 3*PI/8
@export var instability: float = 0.1

var horizontal_angle: float
var vertical_angle: float

var instability_dir: Vector2 = Vector2.RIGHT
var instability_elapsed: float = 0

func _ready() -> void:
	camera_set_rotation(Vector2(starting_horizontal_angle, starting_vertical_angle))

func _process(delta: float) -> void:
	movement(delta)

func movement(delta: float):
	var h_dir: float = 0
	var v_dir: float = 0
	
	if Input.is_key_pressed(KEY_D):
		h_dir += 1
	if Input.is_key_pressed(KEY_A):
		h_dir -= 1 
	if Input.is_key_pressed(KEY_W):
		v_dir += 1
	if Input.is_key_pressed(KEY_S):
		v_dir -= 1
		
	var direction: Vector2 = Vector2(h_dir, v_dir).normalized() * delta * rotate_speed
	if direction.length() != 0:
		camera_rotate(direction)
	
	instability_elapsed += delta
	instability_dir = Vector2(sin(instability_elapsed*0.5), -cos(2*instability_elapsed*0.5))
	
	camera_rotate(instability_dir * instability * delta * 0.25)

func camera_set_rotation(direction: Vector2):
	horizontal_angle = -direction.x
	vertical_angle = clamp(direction.y, min_vertical_angle, max_vertical_angle)
	rotation = Vector3(vertical_angle, horizontal_angle, 0)
	
	rotated.emit(horizontal_angle, vertical_angle)

func camera_rotate(direction: Vector2):
	horizontal_angle = -direction.x + horizontal_angle
	vertical_angle = clamp(direction.y + vertical_angle, min_vertical_angle, max_vertical_angle)
	rotation = Vector3(vertical_angle, horizontal_angle, 0)
	
	rotated.emit(horizontal_angle, vertical_angle)
	
