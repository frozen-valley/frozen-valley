extends Node2D
class_name QuicktimeGame

@onready var _quicktime_game: TreeChopGame = $TreeChopGame

signal finished_quicktime

func _on_finished_quicktime() -> void:
	finished_quicktime.emit()
	
func _ready() -> void:
	_quicktime_game.finished_quicktime.connect(_on_finished_quicktime)

