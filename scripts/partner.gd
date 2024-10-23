extends CharacterBody2D

const SPEED = 300.0
var default_scale_x: float = scale.x
var move_x: float = 0
var direction_x: int = 1

var runToPlayer = true
var isInside = false

@onready var player = get_node("/root/World/Player")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if (runToPlayer):
		var direction = global_position.direction_to(player.global_position) 
		velocity = direction * SPEED
	
	move_x = Input.get_axis("ui_left", "ui_right")

	# Flip based on X direction
	if move_x != 0 && direction_x != sign(move_x):
		direction_x *= -1
		scale.x = default_scale_x * -1
	
	if velocity != Vector2(0,0):
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
		
	move_and_slide()


func _on_area_2d_2_body_entered(body):
	$TimerAssist.start()
	runToPlayer = false
	isInside = true
	
func _on_area_2d_2_body_exited(body):
	isInside = false
	$TimerForWalking.start()

func _on_timer_timeout():
	if (!isInside):
		runToPlayer = true;

func _on_timer_assist_timeout():
	velocity = Vector2(0, 0)
