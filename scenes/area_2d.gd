extends Area2D


func _on_body_entered(body):
	get_parent().get_node("HouseFront").visible = false


func _on_body_exited(body):
	get_parent().get_node("HouseFront").visible = true
