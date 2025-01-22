extends Area2D


func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_body_entered(_body):
	get_parent().get_node("HouseFront").visible = false
	get_parent().get_node("HouseRightWall").visible = false
	get_parent().get_node("HouseBack").z_index = -1



func _on_body_exited(_body):
	get_parent().get_node("HouseFront").visible = true
	get_parent().get_node("HouseRightWall").visible = true
	get_parent().get_node("HouseBack").z_index = 0
