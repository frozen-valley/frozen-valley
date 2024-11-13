extends Node2D
class_name Game

# How much the match should move for
@export var move_for: float = 580 + 100 # 580 but 100 is additional offset for it to go over the line
# Maximum match velocity
@export var _velocity_multiplier: float = 1200
# Velocity curve for the mach
@export var _velocity_curve: Curve

var _matchstick: Matchstick
var _quicktime: Quicktime
var _velocity: float = 0
var _current_position: float
var _initial_position: float
var _x_offset: float
var _start := false
var _confirmed := false
var _finished := false

signal started_quicktime
signal confirmed_quicktime

func _ready() -> void:
	_matchstick = $Match
	_quicktime = $Quicktime

	_initial_position = _matchstick.position.x
	_current_position = _matchstick.position.x

	confirmed_quicktime.connect(_quicktime.on_quicktime_event_confirm)	
	_quicktime.quicktime_finished.connect(_on_quicktime_finished)

func _wait_for_start() -> void:
	var pressed: bool = Input.is_action_just_pressed("ui_accept")
	if (pressed):
		_start = true
		started_quicktime.emit()

func _poll_for_confirm() -> void:
	var pressed: bool = Input.is_action_just_pressed("ui_accept")
	if (pressed):
		_confirmed = true
		confirmed_quicktime.emit()

func _process(delta: float) -> void:
	if (!_start):
		_wait_for_start()
		return
	
	# Calculate the _x_offset and what velocity it should be at
	_current_position = _matchstick.position.x
	_x_offset = (_current_position - _initial_position) / move_for
	_velocity = _velocity_curve.sample(_x_offset) * _velocity_multiplier * delta

	# print(_velocity)
	# Reached the end
	if (is_zero_approx(_velocity) && !_finished):
		_confirmed = true
		confirmed_quicktime.emit()

	_matchstick.position.x += _velocity

	# Poll for confirm if not confirmed and update the _x_offset of the confirmation needle
	if (!_confirmed):
		_quicktime.set_x_offset(_x_offset)
		_poll_for_confirm()

func _on_quicktime_finished(win: bool) -> void:
	_finished = true
	if (win):
		_matchstick.light_on_fire()
	else:
		pass
