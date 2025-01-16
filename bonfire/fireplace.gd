extends Node2D
class_name BonfireFireplace

signal fireplace_finished(win: bool)

enum FireState {
	NO_FIRE,
	FIRE,
	LOGS
}

@export var _max_no_fire_for: float = 6
@export var _flammability_win_con: int = 4
@export var _campfire_y_offset: float = -15

@onready var _insane_smoke_scene := preload("res://bonfire/materials/insane_smoke.tscn")
var _insane_smoke: GPUParticles2D

@onready var _real_campfire_scene := preload("res://bonfire/real_campfire.tscn")
var _real_campfire: AnimatedSprite2D

@onready var _small_fire_scene := preload("res://bonfire/materials/match_fire_particles.tscn")
var _small_fire: GPUParticles2D

@onready var _small_smoke_scene := preload("res://bonfire/materials/small_smoke.tscn")
var _small_smoke: GPUParticles2D

var _check_for_fires := false
var _no_fire_for: float = 0
var _win_con_item: Flammable

## Tracks time passed since animation start
var _campfire_alpha: float = 0
## When the campfire should start appearing
var _campfire_alpha_start: float = 8
## When the campfire be fully present
var _campfire_alpha_max: float = 12
## How long the whole thing should last
var _campfire_stay_for: float = 16

var _won := false
var _created_small_fire := false
var _created_insane_smoke := false

func _process(delta: float) -> void:
	if (_won):
		# Wait for initial 8 seconds to pass
		if (_campfire_alpha >= _campfire_alpha_start && !_created_insane_smoke):
			_insane_smoke = _insane_smoke_scene.instantiate()
			self.add_child(_insane_smoke)
			_insane_smoke.position = _win_con_item.position
			_insane_smoke.position.y += _win_con_item.smoke_y_offset * 4
			_real_campfire = _real_campfire_scene.instantiate()

			self.add_child(_real_campfire)
			_real_campfire.position = _win_con_item.position
			_real_campfire.position.y += _campfire_y_offset
			_real_campfire.self_modulate.a = 0
			_real_campfire.play()
			_created_insane_smoke = true

		# Wait for campfire to fully appear
		if (_campfire_alpha - _campfire_alpha_start >= _campfire_alpha_max - _campfire_alpha_start && !_created_small_fire):
			_small_fire = _small_fire_scene.instantiate()
			self.add_child(_small_fire)
			_small_fire.position = _win_con_item.position
			_small_fire.position.y += _win_con_item.fire_y_offset
			_small_smoke = _small_smoke_scene.instantiate()
			self.add_child(_small_smoke)

			_small_smoke.position = _win_con_item.position
			_small_smoke.position.y += _win_con_item.smoke_y_offset
			_insane_smoke.emitting = false
			_created_small_fire = true

		# Wait for campfire to spawn
		if (_real_campfire != null):
			_real_campfire.self_modulate.a = (_campfire_alpha - _campfire_alpha_start) / (_campfire_alpha_max - _campfire_alpha_start)

		# Animation fully over
		if (_campfire_alpha >= _campfire_stay_for):
			_won = false
			fireplace_finished.emit(true)
			_insane_smoke.queue_free()
			return

		_campfire_alpha += delta

	if (!_check_for_fires):
		return

	if (_no_fire_for >= _max_no_fire_for):
		_lose()

	match(_fires_exist()):
		FireState.NO_FIRE:
			_no_fire_for += delta
		FireState.FIRE:
			_no_fire_for = 0
		FireState.LOGS:
			_win()

func _fires_exist() -> FireState:
	var return_value: FireState = FireState.NO_FIRE
	for child: Node2D in get_children():
		if child is Flammable:
			match child.state:
				Flammable.States.IGNITED, Flammable.States.BURNING:
					if (child.flammability == _flammability_win_con):
						_win_con_item = child
						return FireState.LOGS
					return_value = FireState.FIRE
				_:
					continue
	return return_value

func disable_all_selectables() -> void:
	for child: Node2D in get_children():
		if child is Selectable:
			child.selectable_active = false
	_check_for_fires = true

func _lose() -> void:
	_check_for_fires = false
	fireplace_finished.emit(false)

func _win() -> void:
	_check_for_fires = false
	_won = true

func restart() -> void:
	for child: Node in get_children():
		child.queue_free()
	
	_campfire_alpha = 0
	_won = false
	_check_for_fires = false
	_no_fire_for = 0
	_created_small_fire = false
	_created_insane_smoke = false
	
