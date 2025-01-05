extends Node

@onready var levels: Array[PackedScene] = [
	preload("res://stargazing/stargazing.tscn"),
	preload("res://transitions/stargazing/stargazing_transition.tscn"),
	preload("res://map_levels/level1/map_level1.tscn"),
	preload("res://transitions/river_cross/river_cross_transition.tscn"),
	preload("res://bonfire/bonfire.tscn"),
	preload("res://transitions/bonfire/bonfire_transition.tscn"),
]

var current_scene: Level
var index_current := 0

func _ready() -> void:
	play_next()

func _on_done():
	remove_child(current_scene)
	current_scene.queue_free()
	current_scene = null
	index_current += 1
	if index_current < len(levels):
		play_next()

func play_next():
	current_scene = levels[index_current].instantiate()
	current_scene.connect("done", _on_done)
	add_child(current_scene)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_scene"):
		_on_done()
