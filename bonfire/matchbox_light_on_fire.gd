extends Node2D
class_name MatchboxLightOnFire

@export var _velocity_curve: Curve
var _start: float = -210
var _alpha_full: float = 100
var _end: float = 200
var _current_position: float
var _velocity: float = 0
var _velocity_multiplier: float = 1200
var _x_offset: float = 0
var _ready_to_light := false
var _finished := false

signal match_on_fire

func _ready() -> void:
	$Match.set_flame_alpha(0)
	await get_tree().create_timer(0.5).timeout
	_ready_to_light = true

func _process(delta: float) -> void:
	if (!_ready_to_light || _finished):
		return

	_current_position = $Match.position.x
	_x_offset = (_current_position - _start) / (_end - _start)
	_velocity = _velocity_curve.sample(_x_offset) * _velocity_multiplier * delta

	$Match.position.x += _velocity
	$Match.set_flame_alpha((_current_position - _start) / (_alpha_full - _start))

	if (is_zero_approx(_velocity)):
		_finished = true
		match_on_fire.emit()	
