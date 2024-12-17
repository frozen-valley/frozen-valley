extends Control

signal pressed_play()

func _on_play_pressed():
	pressed_play.emit()


func _on_options_pressed():  
	get_tree().change_scene_to_file("res://UI/optionsScreen.tscn")



func _on_exit_pressed():
	get_tree().quit()
