extends Node2D

signal solved

@export var fireplace: Control
@onready var material_sprite = preload("res://bonfire/sprite_for_material.tscn")
var fireplace_material: Sprite2D

var duration = 0

func _on_matches_pressed() -> void:
	if $GrassMaterial.button_pressed:
		return
	elif not $KindleMaterial.button_pressed:
		return
	elif not $TwigsMaterial.button_pressed:
		duration = 2
	elif $KindleMaterial.button_pressed and $TwigsMaterial.button_pressed and $PlanksMaterial.button_pressed and $LogsMaterial.button_pressed:
		solved.emit()
