extends Level

@export var fireplace: Control
@onready var material_sprite = preload("res://bonfire/sprite_for_material.tscn")
var fireplace_material: Sprite2D

var duration = 0

func _ready() -> void:
	Dialogic.start("bonfire_intro")
	Dialogic.signal_event.connect(start_game)

func start_game(arg):
	if arg == "start_bonfire":
		$Materials.visible = true
	else:
		printerr("Unknown signal fired: " + arg)

func _on_matches_pressed() -> void:
	if $Materials/GrassMaterial.button_pressed:
		return
	elif not $Materials/KindleMaterial.button_pressed:
		return
	elif not $Materials/TwigsMaterial.button_pressed:
		duration = 2
	elif $Materials/KindleMaterial.button_pressed and $Materials/TwigsMaterial.button_pressed and $Materials/PlanksMaterial.button_pressed and $Materials/LogsMaterial.button_pressed:
		finish()
