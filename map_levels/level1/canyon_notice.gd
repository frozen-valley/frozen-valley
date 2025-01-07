extends Area2D



var seen = false
func _on_body_entered(body: Node2D) -> void:
	var player_body = body as Player
	if (!player_body):
		return
	if not seen:
		seen = true
		Dialogic.Inputs.auto_advance.enabled_forced = true
		Dialogic.start("found_canyon")
