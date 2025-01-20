extends Level


func _on_play_pressed():
	finish()

func _on_options_pressed():
	$OptionsMenu.show()
	$VBoxContainer.hide()

func _on_exit_pressed():
	get_tree().quit()


func _on_options_menu_pressed_back() -> void:
	$OptionsMenu.hide()
	$VBoxContainer.show()
