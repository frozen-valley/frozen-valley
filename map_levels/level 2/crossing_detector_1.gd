extends Area2D

var transition_counter = 0
@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	TransitionScreen.on_transition_finished.connect(_on_finished)

func _on_body_entered(body):
	if (body is not Player):
		return
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	place_player()

func place_player():
	player.global_position = Vector2(1291,824)

func _on_finished():
	Dialogic.start("north_finding")
		
