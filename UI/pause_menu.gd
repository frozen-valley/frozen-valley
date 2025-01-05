extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	$AnimationPlayer.play_backwards("blur")
	$PauseCanvas.layer = 0
	get_tree().paused = false

func pause():
	$AnimationPlayer.play("blur")
	$PauseCanvas.layer = 20
	get_tree().paused = true

func deffer_tree(pause_mode = false):
	get_tree().create_timer(0.1).timeout.connect(func(): set_tree_pause(pause_mode))

func set_tree_pause(pause_mode):
	get_tree().paused = pause_mode
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if !get_tree().paused:
			pause()
		else:
			resume()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().quit()
