extends Level


func _on_tree_chop_game_finished_quicktime() -> void:
	finish()

func _ready() -> void:
	Dialogic.start("tree_chop_tutorial")
