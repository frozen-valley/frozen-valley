extends Sprite2D

var in_range: bool = false
var is_open: bool = false
var read = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	$"../CanvasLayer/TextureRect".show()
	hide()


func _on_area_2d_body_exited(body: Node2D) -> void:
	$"../CanvasLayer/TextureRect".hide()
	show()
	if not read:
		Dialogic.start("read_letter")
	read = true
