extends Control

func _ready() -> void:
	$Crosshair.visible = false
	$FingerPointing.visible = false

func _on_stargazing_dialogue_manager_intro_dialogue_ended() -> void:
	$FingerPointing.visible = true

func _on_stargazing_dialogue_manager_explanation_dialogue_ended() -> void:
	$Crosshair.visible = true
