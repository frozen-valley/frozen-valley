extends Area2D

var entered = false
var has_axe = false
var all_solved = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		entered = true


func _on_axe_tree_exiting() -> void:
	has_axe = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and entered:
		if not all_solved:
			Dialogic.start("need_items")
		else:
			$"../../..".finish()

func _on_objectives_manager_all_solved() -> void:
	all_solved = true
