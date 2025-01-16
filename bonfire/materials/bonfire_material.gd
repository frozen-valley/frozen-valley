extends Selectable
class_name Flammable

## Flammable states
## DORMANT = item has not yet been on fire
## IGNITED = item has been ignited and is starting to burn
## BURNING = item is currently on fire
## BURNT   = item has finished burning and will start decaying
## ASHED   = item has burnt to a crisp and is fully decayed
enum STATES {
	DORMANT,
	IGNITED,
	BURNING,
	BURNT,
	ASHED
}

## Controls the level of flammability. The lower the flammability, the longer it burns.
## Flammable with flammability x sets every Flammable with flammability <= x+1 on fire.
@export var flammability: int 

## Changes some of the flammability behaviour
@export var wet: bool = false

## Flag for the match. Changes burning behaviour
@export var is_match := false

## State of the Flammable
var state: STATES = STATES.DORMANT

## How much heat is on the materal. Used for deciding whether it should light on fire
var _flames_on_me: float = 0

## Tracks how long the material has been in ignition state
var _ignition_duration: float = 0
## Maximum ignition state duration
var _max_ignition_duration: float = 0

## Tracks how long the material has been in ignition state
var _has_burned_for: float = 0
## Maximum burn state duration
var _max_burn_duration: float = 0

## Tracks how long the material has been in smoking state
var _smoking_duration: float = 0
## Maximum smoking state duration
var _max_smoking_duration: float = 0

@export var fire_scene: PackedScene = preload("res://bonfire/materials/fire.tscn")
@export var smoke_scene: PackedScene = preload("res://bonfire/materials/smoke.tscn")
@export var fire_y_offset: int = 30
@export var smoke_y_offset: int = 10

var _fire: GPUParticles2D
var _fire_burning: GPUParticles2D
var _smoke: GPUParticles2D

func _ready() -> void:
	super()

	scale = Vector2(0.5, 0.5)
	_max_ignition_duration = flammability 
	_max_burn_duration = flammability * 2
	_max_smoking_duration = flammability
	
	if (!wet):
		_max_burn_duration /= 2

	if (is_match):
		_max_ignition_duration = 0.5
		_max_burn_duration = 0.5
		_max_smoking_duration = 0.5

func _process(delta: float) -> void:
	super(delta)

	if (Input.is_action_just_pressed("interact")):
		_change_state(STATES.IGNITED)

	match(state):
		STATES.DORMANT:
			_state_dormant()
		STATES.IGNITED:
			_state_ignited(delta)
		STATES.BURNING:
			_state_burning(delta)
		STATES.BURNT:
			_state_burnt(delta)
		STATES.ASHED:
			_state_ashed()

func _state_dormant() -> void:
	_flames_on_me = 0
	for other: Area2D in get_overlapping_areas():
		if (other is not Flammable):
			continue

		if (other.state == STATES.DORMANT || other.state == STATES.BURNT):
			continue

		if (other.state == STATES.IGNITED && other.flammability < flammability):
			continue
		
		if (other.is_match && flammability == 1):
			_flames_on_me += 5

		# If we want strict progression we can add this
		# if (other.flammability >= flammability - 1):
		if (other.wet):
			_flames_on_me += other.flammability / 2
		else:
			_flames_on_me += other.flammability

	if (_flames_on_me > 0 && _flames_on_me >= flammability - 1):
		_change_state(STATES.IGNITED)

func _state_ignited(delta: float) -> void:
	if (_ignition_duration >= _max_ignition_duration):
		_change_state(STATES.BURNING)
		return

	_ignition_duration += delta

func _state_burning(delta: float) -> void:
	# print("has burned for ", _has_burned_for, " but needs to burn for ", _max_burn_duration)
	if (_has_burned_for >= _max_burn_duration):
		_change_state(STATES.BURNT)
		return
	_has_burned_for += delta

func _state_burnt(delta: float) -> void:
	if (_smoking_duration >= _max_smoking_duration):
		_change_state(STATES.ASHED)
		return
	_smoking_duration += delta
	if (!is_match):
		$Sprite2D.self_modulate.a = 1 - _smoking_duration / _max_smoking_duration

func _state_ashed() -> void:
	# Do nothing :)
	pass

func _change_state(new_state: STATES) -> void:
	print("Changing from ", state, " to ", new_state)
	state = new_state
	match(new_state):
		STATES.DORMANT:
			pass
		STATES.IGNITED when !is_match:
			selectable_active = false
			_fire = fire_scene.instantiate()
			_fire.global_position.y += fire_y_offset
			self.add_child(_fire)
		STATES.BURNING when !is_match:
			_smoke = smoke_scene.instantiate()
			_smoke.global_position.y += smoke_y_offset
			_fire_burning = fire_scene.instantiate()
			_fire_burning.global_position.y += fire_y_offset
			self.add_child(_fire_burning)
			self.add_child(_smoke)
		STATES.BURNT when !is_match:
			_fire.emitting = false
			_fire_burning.emitting = false
			await get_tree().create_timer(_fire.lifetime).timeout
			_fire.queue_free()
			_fire_burning.queue_free()
		STATES.ASHED when !is_match:
			_smoke.emitting = false
			await get_tree().create_timer(_smoke.lifetime).timeout
			_smoke.queue_free()
