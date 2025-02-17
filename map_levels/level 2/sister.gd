extends Sprite2D

signal found

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Dialogic.start("found_sister")
		found.emit()
