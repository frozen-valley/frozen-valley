extends Area2D


func _on_body_entered(_body):
	get_parent().get_node("HouseFront").visible = false


func _on_body_exited(_body):
	get_parent().get_node("HouseFront").visible = true
