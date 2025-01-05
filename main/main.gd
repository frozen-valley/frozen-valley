extends Node

@onready var levels: Array[PackedScene] = [
	preload("res://stargazing/stargazing.tscn"),
	preload("res://map_levels/level1/map_level1.tscn"),
	preload("res://bonfire/bonfire.tscn")
]

var current_scene: Level
var index_current := -1

func _ready() -> void:
	play_next()

func _on_done():
	remove_child(current_scene)
	current_scene.queue_free()
	current_scene = null

func play_next():
	index_current += 1
	current_scene = levels[index_current].instantiate()
	current_scene.connect("done", _on_done)
	add_child(current_scene)
	
