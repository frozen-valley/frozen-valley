extends Node

@onready var stargazing_preload = preload("res://stargazing/stargazing.tscn")

var stargazing_scene

func _ready() -> void:
	stargazing_scene = stargazing_preload.instantiate()
	stargazing_scene.connect("solved", solved_stargazing)
	add_child(stargazing_scene)

func solved_stargazing():
	stargazing_scene.queue_free()
