extends Level


func _on_play_pressed():
	finish()

func _on_options_pressed():
	$OptionsMenu.visible = true
	$MarginContainer.visible = false

func _on_exit_pressed():
	get_tree().quit()


func _on_options_menu_pressed_back() -> void:
	$OptionsMenu.visible = false
	$MarginContainer.visible = true
