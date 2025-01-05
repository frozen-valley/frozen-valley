extends Level


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_scene"):
		finish()

func _on_stargazing_tutorial_all_solved() -> void:
	finish()
