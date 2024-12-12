extends Node

@onready var stargazing_preload = preload("res://stargazing/stargazing.tscn")
@onready var map_level1_preload = preload("res://map/level1/map_level1.tscn")
@onready var chop_preload = preload("res://tree_chop_game/tree_chop_game.tscn")
@onready var bonfire_preload = preload("res://bonfire/bonfire.tscn")

@export var begin_level1 = false

var stargazing_scene
var map_level1_scene
var chop_scene
var bonfire_scene

func _ready() -> void:
	if begin_level1:
		start_level1()
	else:
		start_stargazing()


func start_stargazing():
	stargazing_scene = stargazing_preload.instantiate()
	stargazing_scene.connect("solved", end_stargazing)
	add_child(stargazing_scene)

func end_stargazing():
	stargazing_scene.queue_free()
	start_level1()

func start_level1():
	map_level1_scene = map_level1_preload.instantiate()
	map_level1_scene.connect("play_chop", end_level1)
	add_child(map_level1_scene)
	
func end_level1():
	remove_child(map_level1_scene)
	start_chop()

func start_chop():
	chop_scene = chop_preload.instantiate()
	chop_scene.connect("finished_quicktime", end_chop)
	add_child(chop_scene)

func end_chop():
	chop_scene.queue_free()
	start_level12()

func start_level12():
	add_child(map_level1_scene)
	map_level1_scene.connect("solved", end_level12)
	map_level1_scene.do_solved_minigame()

func end_level12():
	map_level1_scene.queue_free()
	start_bonfire()

func start_bonfire():
	bonfire_scene = bonfire_preload.instantiate()
	bonfire_scene.connect("solved", end_bonfire)
	add_child(bonfire_scene)

func end_bonfire():
	bonfire_scene.queue_free()
