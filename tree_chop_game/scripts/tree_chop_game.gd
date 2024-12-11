extends Node2D
class_name TreeChopGame

@onready var _quicktime: Quicktime = $Quicktime
@onready var _axe: QuicktimeItem = $Axe

# How much the match should move for
@export var move_for: float = 580 + 100 # 580 but 100 is additional offset for it to go over the line
# Maximum match velocity
@export var _velocity_multiplier: float = 1200
# Velocity curve for the mach
@export var _velocity_curve: Curve

var _velocity: float = 0
var _current_position: float
var _initial_position: float
var _x_offset: float
var _start := false
var _confirmed := false
var _finished := false

signal started_quicktime
signal confirmed_quicktime
signal finished_quicktime

func end_quicktime() -> void: 
	finished_quicktime.emit()

func restart_quicktime() -> void: 
	_quicktime.restart_quicktime()
	_axe.restart_quicktime()
	_start = false
	_confirmed = false
	_finished = false
	_velocity = 0
	_x_offset = 0
	_current_position = 0

func _ready() -> void:
	_initial_position = _axe.position.x
	_current_position = _axe.position.x

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
	_current_position = _axe.position.x
	_x_offset = (_current_position - _initial_position) / move_for
	_velocity = _velocity_curve.sample(_x_offset) * _velocity_multiplier * delta

	# print(_velocity)
	# Reached the end
	if (is_zero_approx(_velocity) && !_finished):
		_confirmed = true
		confirmed_quicktime.emit()

	_axe.position.x += _velocity

	# Poll for confirm if not confirmed and update the _x_offset of the confirmation needle
	if (!_confirmed):
		_quicktime.set_x_offset(_x_offset)
		_poll_for_confirm()

func _on_quicktime_finished(win: bool) -> void:
	_finished = true
	if (win):
		_axe.light_on_fire()
	else:
		pass
