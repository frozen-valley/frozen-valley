extends Node2D
class_name BonfireFireplace

@export var _max_no_fire_for: float = 5
var _check_for_fires := false
var _no_fire_for: float = 0
var _log_placed_down := false

signal fireplace_finished(win: bool)

func _process(delta: float) -> void:
	if (!_check_for_fires):
		return

	if (!_log_placed_down):
		_lose(2.0)

	if (_no_fire_for >= _max_no_fire_for):
		_lose()

	if(!_fires_exist()):
		_no_fire_for += delta
	else:
		print("FIREEEEEEE")
		_no_fire_for = 0

func _fires_exist() -> bool:
	for child: Node2D in get_children():
		if child is Flammable:
			match child.state:
				Flammable.STATES.IGNITED, Flammable.STATES.BURNING:
					return true
				_:
					continue
	return false

func disable_all_selectables():
	for child: Node2D in get_children():
		if child is Selectable:
			child.selectable_active = false
	_check_for_fires = true

func _lose(time_to_wait: float = 0):
	_check_for_fires = false
	print("dead")
	if (!time_to_wait):
		await get_tree().create_timer(2.0).timeout
	fireplace_finished.emit(false)

func _win():
	print("alive")
	fireplace_finished.emit(true)
