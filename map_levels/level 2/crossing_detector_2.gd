extends Area2D

@onready var player = get_parent().get_node("Player")

func _on_body_entered(body):
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	place_player()

func place_player():
	player.global_position = Vector2(3185,747)
