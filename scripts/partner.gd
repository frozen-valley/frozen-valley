extends CharacterBody2D
class_name Partner

const SPEED = 300.0
@export var player: Player
@export var distance_treshold: float = 160
@export var distance_leeway: float = 50
var default_scale_x: float = scale.x
var move_x: float = 0
var direction_x: int = 1

var running := false

var direction: Vector2
var distance: float 

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	if (!player):
		queue_free()
		return

func _process(_delta: float) -> void:	
	distance = global_position.distance_to(player.global_position)
	direction = global_position.direction_to(player.global_position) 
	if (running):
		running = distance > distance_treshold - distance_leeway
	else:
		running = distance > distance_treshold + distance_leeway

func _physics_process(_delta: float) -> void:
	if (running):
		velocity = direction * SPEED
	else:
		velocity = Vector2(0, 0)
	
	if (direction.angle() > (-PI / 2.0) && direction.angle() < (PI / 2.0)):
		move_x = 1
	else:
		move_x = -1

	# Flip based on X direction
	if move_x != 0 && direction_x != sign(move_x):
		direction_x *= -1
		scale.x = default_scale_x * -1
	
	if velocity != Vector2(0,0):
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
		
	move_and_slide()	
