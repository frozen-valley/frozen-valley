extends Button
class_name MaterialButton

@export var fireplace: Node
@export var bonfire_material: PackedScene
@export var move_for_multiplier: int = 100

@onready var _icon: Texture2D = icon
@onready var _empty_icon: Texture2D = preload("res://bonfire/sprites/empty_200x200.png")

var _fireplace_material: Flammable

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_fireplace_material = bonfire_material.instantiate()
		fireplace.add_child(_fireplace_material)
		var index = _fireplace_material.get_index() 
		var child_count = fireplace.get_child_count()
		var move_for = (child_count / 2.0) * move_for_multiplier - index * move_for_multiplier
		_fireplace_material.global_position.x -= move_for
		icon = _empty_icon
	else:
		fireplace.remove_child(_fireplace_material)
		_fireplace_material.queue_free()
		_fireplace_material = null
		icon = _icon

func restart() -> void:
	button_pressed = false
	icon = _icon
