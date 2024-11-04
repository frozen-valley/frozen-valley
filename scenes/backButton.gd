extends Area2D


func _on_area_entered(area):
	self.show()


func _on_area_exited(area):
	self.hide()
