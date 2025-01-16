extends Node2D
class_name BonfireMatch

@onready var flammable: Flammable = $Flame/Area2D

var _placed := false
var _fadeout_timer: float = 0
var _fadeout_duration: float = 2

signal match_placed

func _ready() -> void:
	scale = Vector2(0.5, 0.5)
	flammable.selectable_active = false

func _process(delta: float) -> void:
	if (_placed):
		if (flammable.state != Flammable.States.ASHED):
			return

		if (_fadeout_timer >= _fadeout_duration):
			queue_free()

		_fadeout_timer += delta
		$Sprite2D.self_modulate.a = 1 - (_fadeout_timer / _fadeout_duration)
		$Flame.self_modulate.a = 1 - (_fadeout_timer / _fadeout_duration)
		$Flame/GPUParticles2D.emitting = false
		return

	global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if (_placed):
		return

	if (event is InputEventMouseButton && event.button_index == 1):
		if (event.is_pressed()):
			_placed = true
			flammable._change_state(Flammable.States.IGNITED)
			match_placed.emit()
