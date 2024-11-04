extends Area2D

func _ready():
	input_pickable = true
	#self.connect("mouse_entered", self, "onMouseHover")

func onMouseHover():
	self.visible = true


func _on_mouse_entered():
	self.visible = true
