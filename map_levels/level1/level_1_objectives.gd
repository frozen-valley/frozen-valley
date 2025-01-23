extends Control


func _ready() -> void:
	$ObjectivesManager.start()


func _on_key_tree_exited() -> void:
	$ObjectivesManager.solve(4)

func _on_axe_tree_exiting() -> void:
	$ObjectivesManager.solve(6)

func _on_plank_tree_exited() -> void:
	$ObjectivesManager.solve(2)

func _on_logs_tree_exited() -> void:
	$ObjectivesManager.solve(3)

func _on_kindle_tree_exited() -> void:
	$ObjectivesManager.solve(0)

func _on_twigs_tree_exited() -> void:
	$ObjectivesManager.solve(1)

func _on_house_door_tree_exited() -> void:
	$ObjectivesManager.solve(5)
