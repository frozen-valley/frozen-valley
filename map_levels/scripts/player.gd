extends CharacterBody2D
class_name Player

const SPEED: float = 300.0
var default_scale_x: float = scale.x

var direction_x: int = 1
var pickup_queue: Array[Pickupable]
var move := Vector2(0, 0)

@export var inventory: Inventory
@onready var animated_sprite = $AnimatedSprite2D


func _add_to_inventory(item: Pickupable) -> void:
	var item_type = item.item
	item.pick_me_up(self)
	inventory.insert(item_type)

func _pickup() -> void:
	var item: Pickupable = pickup_queue[0]
	_add_to_inventory(item)		
	pickup_queue.remove_at(0)

func _use_key():
	inventory.remove_key()

func _listen_for_pickups() -> void:
	var interact: bool = Input.is_action_just_pressed("interact")
	if (interact): 
		_pickup()

func add_to_pickup_queue(item: Pickupable) -> void:
	pickup_queue.push_back(item)

func remove_from_pickup_queue(item: Pickupable) -> void:
	pickup_queue.erase(item)

func _process(_delta: float) -> void:
	if !pickup_queue.is_empty():
		_listen_for_pickups()	
	if velocity == Vector2(0,0):
		$AudioStreamPlayer2D.play()

func _physics_process(_delta: float) -> void:
	# Get the input directions
	var move_x: float = 0
	var move_y: float = 0
		
	if Input.is_action_pressed("move_left"):
		move_x -= 1
	if Input.is_action_pressed("move_right"):
		move_x += 1
	if Input.is_action_pressed("move_up"):
		move_y -= 1
	if Input.is_action_pressed("move_down"):
		move_y += 1
	
	move = Vector2(move_x, move_y)
	
	# Normalize to avoid diagonal speedup
	move = move.normalized()
	
	# Flip based on X direction
	if move_x != 0 && direction_x != sign(move_x):
		direction_x *= -1
		scale.x = default_scale_x * -1
	
	if move != Vector2(0,0):
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	# Update the velocity
	velocity = move * SPEED
	move_and_slide()


func _on_door_detector_area_used_key() -> void:
	_use_key()
