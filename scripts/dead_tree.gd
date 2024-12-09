extends StaticBody2D
class_name DeadTreee

@export var player: Player 
@export var distance_treshold: float = 300
var distance: float = 0

func play_quicktime() -> void:
	if (player.inventory.has_item("stick")):
		print("play game")
	else:
		print("no axe")

func _ready() -> void:
	if (!player):
		queue_free()

func _process(_delta: float) -> void:
	distance = global_position.distance_to(player.global_position)

	if (distance >= distance_treshold):
		return
	
	var interact: bool = Input.is_action_just_pressed("interact")
	if (interact):
		play_quicktime()
