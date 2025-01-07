extends Level
class_name Transition

@export var float_movement: bool = true
@export var float_speed: float = 5

@export var phase_in: bool = true
@export var phase_in_time: float = 3
@export var transition_time: float = 10

var passed_time := 0.0
@onready var sprite = $Sprite2D

var float_dir: Vector2
const screen_size = Vector2(1920, 1080)

func _ready():
	if float_movement:
		var rand_angle := randf_range(0, 2*PI)
		float_dir = Vector2(cos(rand_angle), sin(rand_angle))
		sprite.position -= float_dir * (float_speed * transition_time / 2.0)
		var translation: Vector2 = sprite.position - screen_size/2.0
		var translation_factor: Vector2 = abs(translation / screen_size)
		var scale_needed: float = 1 + 2*max(translation_factor.x, translation_factor.y)
		sprite.scale = Vector2.ONE * scale_needed
		

func _process(delta: float) -> void:
	if float_movement:
		sprite.position += float_dir * float_speed * delta
	
	if phase_in:
		sprite.modulate = lerp(Color.BLACK, Color.WHITE, min(1, passed_time/phase_in_time))
	
	if passed_time > transition_time:
		finish()
	
	passed_time += delta
