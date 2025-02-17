extends Control

func _on_sister_found() -> void:
	$ObjectivesManager.solve()


func _on_note_opened() -> void:
	$ObjectivesManager.start()
