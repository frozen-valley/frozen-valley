extends Node


func _on_stargazing_dialogue_manager_explanation_dialogue_ended() -> void:
	$ObjectivesManager.start()
	
func _on_stargazing_tutorial_load_star_group(_star_group_index: int) -> void:
	$ObjectivesManager.solve()

func _on_book_opened() -> void:
	if $ObjectivesManager.solve_count == 0:
		$ObjectivesManager.solve()
