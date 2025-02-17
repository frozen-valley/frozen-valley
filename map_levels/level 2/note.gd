extends Sprite2D

signal opened

var in_range: bool = false
var read = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$"../../CanvasLayer/TextureRect".show()
	hide()
	opened.emit()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	$"../../CanvasLayer/TextureRect".hide()
	show()
	if not read:
		Dialogic.start("read_letter")
	read = true
