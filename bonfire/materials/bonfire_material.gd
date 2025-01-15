extends Selectable
class_name Flammable

## Flammable states
## DORMANT = item has not yet been on fire
## BURNING = item is currently on fire
## BURNT   = item has burnt to a crisp
enum STATES {
	DORMANT,
	BURNING,
	BURNT
}

## Controls the level of flammability. The lower the flammability, the longer it burns.
## Flammable with flammability x sets every Flammable with flammability <= x+1 on fire.
@export var flammability: int 

## If a material is wet, it sets each Flammable with flammability <= x - 1 on fire.
## Halves the burn time.
@export var wet: bool = false

## State of the Flammable
var state: STATES = STATES.DORMANT

var _flames_on_me: float = 0
var _has_burned_for: float = 0
var _max_burn_duration: float = 0

@export var fire_scene: PackedScene = preload("res://bonfire/materials/fire.tscn")
@export var smoke_scene: PackedScene = preload("res://bonfire/materials/smoke.tscn")
@export var fire_y_offset: int = 30
@export var smoke_y_offset: int = 10
var _fire: GPUParticles2D
var _smoke: GPUParticles2D

func _ready() -> void:
	super()

	scale = Vector2(0.5, 0.5)
	_max_burn_duration = flammability
	if (!wet):
		_max_burn_duration *= 2

func _process(delta: float) -> void:
	super(delta)

	if (Input.is_action_just_pressed("interact")):
		_change_state(STATES.BURNING)

	match(state):
		STATES.DORMANT:
			_state_dormant()
		STATES.BURNING:
			_state_burning(delta)
		STATES.BURNT:
			_state_burnt()

func _state_dormant() -> void:
	_flames_on_me = 0
	for other: Area2D in get_overlapping_areas():
		if (other.state != STATES.BURNING):
			continue

		# If we want strict progression we can add this
		# if (other.flammability >= flammability - 1):
		if (other.wet):
			_flames_on_me += other.flammability / 2
		else:
			_flames_on_me += other.flammability

	if (_flames_on_me > 0 && _flames_on_me >= flammability - 1):
		_change_state(STATES.BURNING)

func _state_burning(delta: float) -> void:
	# print("has burned for ", _has_burned_for, " but needs to burn for ", _max_burn_duration)
	if (_has_burned_for >= _max_burn_duration):
		_change_state(STATES.BURNT)
		return
	_has_burned_for += 1 * delta

func _state_burnt() -> void:
	# Do nothing :)
	pass

func _change_state(new_state: STATES) -> void:
	print("Changing from ", state, " to ", new_state)
	state = new_state
	match(new_state):
		STATES.DORMANT:
			# Apply no shader
			# Apply no particles
			pass
		STATES.BURNING:
			await get_tree().create_timer(0.1).timeout
			selectable_active = false
			_fire = fire_scene.instantiate()
			_fire.global_position.y += fire_y_offset
			self.add_child(_fire)
			# Apply burning shader
			# Apply flame particles
			pass
		STATES.BURNT:
			_fire.emitting = false
			_smoke = smoke_scene.instantiate()
			_smoke.global_position.y += smoke_y_offset
			self.add_child(_smoke)
			await get_tree().create_timer(_fire.lifetime).timeout
			_fire.queue_free()
			# Apply burnt shader
			# Apply no particles
			pass	

