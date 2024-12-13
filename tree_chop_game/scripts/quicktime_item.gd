extends Node2D
class_name QuicktimeItem

@export var burn_sprite: Texture2D
@onready var _sprite: Sprite2D = $Sprite2D
var _initial_position: Vector2

func light_on_fire() -> void:
	if (!_sprite || !burn_sprite):
		return
	_sprite.texture = burn_sprite

func _ready() -> void:
	_initial_position = position

func restart_quicktime() -> void:
	position = _initial_position

func _process(_delta: float) -> void:
	pass

