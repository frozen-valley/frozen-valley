extends Node2D
class_name Quicktime

@export var correct: Color = Color("11fa19")
@export var background: Color = Color("efefff")
@export var border: Color = Color("03091e")
@export var needle_color: Color = Color("fa0903")
@export var needle_width: float = 5
@export var x_size: float = 580
var correct_start: float = 3  * (x_size / 5)
var correct_width: float = x_size / 10

var _x_offset: float = 0
var _confirmed := false

signal quicktime_finished (win: bool)

func restart_quicktime() -> void:
	_confirmed = false
	_x_offset = 0

func set_x_offset(new_x_offset: float) -> void:
	_x_offset = min(x_size - needle_width, x_size * new_x_offset)

func _win() -> void:
	quicktime_finished.emit(true)

func _lose() -> void:
	quicktime_finished.emit(false)

func on_quicktime_event_confirm() -> void:
	_confirmed = true
	# If in the green
	if (_x_offset >= correct_start && _x_offset <= correct_start + correct_width):
		_win()
	else:
		_lose()

func _process(_delta: float) -> void:
	# Redraw only if not confirmed (makes the needle stop if confirmed)
	if (!_confirmed):
		queue_redraw()

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("skip_scene"):
		#_win()

func _draw():
	$Marker.position.x = _x_offset - 18

	#draw_rect(Rect2(0, 0, x_size, 100.0), background)
	#draw_rect(Rect2(correct_start, 0, correct_width, 100.0), correct)
	#draw_rect(Rect2(_x_offset, 0, needle_width, 100.0), needle_color)
	#draw_rect(Rect2(0, 0, x_size, 100.0), border, false, 6.0)
