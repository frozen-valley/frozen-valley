extends CharacterBody2D
class_name Partner

const SPEED: float = 300.0
const POSSIBLE_DIRECTIONS: Array[Vector2] = [
	Vector2(1, 0), # 0
	Vector2(sqrt(2) / 2.0, -sqrt(2) / 2.0), # PI / 4.0
	Vector2(0, -1), # PI / 2.0
	Vector2(-sqrt(2) / 2.0, -sqrt(2) / 2.0), # 3 * PI / 4.0
	Vector2(-1, 0), # PI
	Vector2(-sqrt(2) / 2.0, sqrt(2) / 2.0), # 5 * PI / 4.0
	Vector2(0, 1), # 3 * PI / 2.0
	Vector2(sqrt(2) / 2.0, sqrt(2) / 2.0) # 7 * PI / 4.0
	]
@export var player: Player
@export var distance_treshold: float = 160
@export var distance_leeway: float = 50
# The minimum walk amount required before changing move_direction
@export var minimum_step_direction_time: float = 0.65
var default_scale_x: float = scale.x
var move_x: float = 0
var direction_x: int = 1

var running := false

var direction: Vector2
var move_direction: Vector2 = Vector2(0, 0)
var distance: float = 0
var previous_move_direction: Vector2
var can_change_direction := true

var target_position: Vector2 = Vector2(0, 0)
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@onready var animated_sprite = $AnimatedSprite2D

func _closest_to_angle(dir: Vector2) -> Vector2:
	var angle: float = dir.angle()	
	var current: Vector2 = POSSIBLE_DIRECTIONS[0]
	var current_diff: float = abs(current.angle() - angle)

	for possible_dir: Vector2 in POSSIBLE_DIRECTIONS:
		var possible_angle: float = possible_dir.angle()
		var diff = abs(possible_angle - angle)	
		if (diff < current_diff):
			current = possible_dir
			current_diff = diff	

	return current

func _ready() -> void:
	if (!player):
		queue_free()
		return
	default_scale_x = animated_sprite.scale.x

func _process(_delta: float) -> void:	
	distance = global_position.distance_to(player.global_position)
	navigation_agent.target_position = player.position

func _physics_process(_delta: float) -> void:
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	direction = _closest_to_angle(current_agent_position.direction_to(next_path_position))
	previous_move_direction = move_direction

	if (can_change_direction):
		move_direction = _closest_to_angle(direction)

	if (previous_move_direction != move_direction):
		can_change_direction = false
		await get_tree().create_timer(minimum_step_direction_time).timeout
		can_change_direction = true

	if (running):
		running = distance > distance_treshold 
		velocity = move_direction * SPEED
	else:
		running = distance > distance_treshold + distance_leeway
		velocity = Vector2(0, 0)

	if velocity != Vector2(0,0):
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	
	# Flip based on X direction
	if (direction.angle() > (-PI / 2.0) && direction.angle() < (PI / 2.0)):
		move_x = 1
	else:
		move_x = -1

	if (direction_x != sign(move_x)):
		direction_x *= -1
		animated_sprite.scale.x = default_scale_x * move_x
	
	move_and_slide()	
