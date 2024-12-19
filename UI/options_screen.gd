extends Control

signal pressed_back()

func _on_back_pressed():  
	pressed_back.emit()
	
