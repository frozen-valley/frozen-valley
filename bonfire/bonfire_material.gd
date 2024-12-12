extends Button

@export var fireplace: Control
@onready var material_sprite = preload("res://bonfire/sprite_for_material.tscn")
var fireplace_material: Sprite2D


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		fireplace.remove_child(fireplace_material)
		fireplace_material.queue_free()
		fireplace_material = null
	else:
		fireplace_material = material_sprite.instantiate()
		fireplace_material.texture = icon
		fireplace.add_child(fireplace_material)
