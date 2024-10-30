extends Node2D
class_name Matchstick

@export var burn_sprite: Texture2D
var _sprite: Sprite2D

func light_on_fire() -> void:
	if (!_sprite || !burn_sprite):
		return
	_sprite.texture = burn_sprite

func _ready() -> void:
	_sprite = $Sprite2D

func _process(_delta: float) -> void:
	pass

