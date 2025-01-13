extends Level
class_name BonfireGame

@export var fireplace: Node
@onready var material_sprite = preload("res://bonfire/sprite_for_material.tscn")
@onready var materials: Control = $Materials
var fireplace_material: Flammable

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
	if $Materials/GrassButton.button_pressed:
		return
	elif not $Materials/KindleButton.button_pressed:
		return
	elif not $Materials/TwigsButton.button_pressed:
		duration = 2
	elif $Materials/KindleButton.button_pressed and $Materials/TwigsButton.button_pressed and $Materials/PlanksButton.button_pressed and $Materials/LogsButton.button_pressed:
		finish()
