extends Control

signal pressed_play()
signal pressed_options()

func _on_play_pressed():
	pressed_play.emit()


func _on_options_pressed():  
	pressed_options.emit()


func _on_exit_pressed():
	get_tree().quit()
