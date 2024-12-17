extends Node

@onready var startScreen_preload = preload("res://UI/startScreen.tscn")
@onready var stargazing_preload = preload("res://stargazing/stargazing.tscn")
@onready var map_level1_preload = preload("res://map/level1/map_level1.tscn")
@onready var chop_preload = preload("res://tree_chop_game/tree_chop_game.tscn")
@onready var bonfire_preload = preload("res://bonfire/bonfire.tscn")

@export var begin_level1 = false

var startScreen_scene
var stargazing_scene
var map_level1_scene
var chop_scene
var bonfire_scene

func _ready() -> void:
	if begin_level1:
		start_level1()
	else:
		start_startScreen()
		#start_stargazing()

func start_startScreen():
	startScreen_scene = startScreen_preload.instantiate()
	startScreen_scene.connect("pressed_play", start_stargazing)
	add_child(startScreen_scene)
	
func start_stargazing():
	startScreen_scene.queue_free()
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
	add_child(map_level1_scene)
	map_level1_scene.connect("solved", start_cross_river)
	map_level1_scene.do_solved_minigame()

func start_cross_river():
	map_level1_scene.queue_free()
	start_bonfire()

func start_bonfire():
	bonfire_scene = bonfire_preload.instantiate()
	bonfire_scene.connect("solved", end_bonfire)
	add_child(bonfire_scene)

func end_bonfire():
	bonfire_scene.queue_free()
	Dialogic.start("ending")
