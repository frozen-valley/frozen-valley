extends Node2D

signal play_chop
signal solved_chop
signal solved

func _on_cross_river_button_pressed() -> void:
	solved.emit()

func _on_dead_tree_play_minigame() -> void:
	play_chop.emit()

func _on_dead_tree_minigame_solved() -> void:
	solved_chop.emit()

func do_solved_minigame():
	var log_and_stump_resource := load("res://map_levels/sub_scenes/log_and_stump.tscn") 
	var log_and_stump_node = log_and_stump_resource.instantiate()
	log_and_stump_node.position = Vector2(-681, -796)
	log_and_stump_node.scale.x *= -1
	add_child(log_and_stump_node)
	$CrossRiverButton.visible = true
	$Trees/DeadTree.queue_free()
