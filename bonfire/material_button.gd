extends Button
class_name MaterialButton

@export var fireplace: Node
@export var bonfire_material: PackedScene
var fireplace_material: Flammable

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		fireplace_material = bonfire_material.instantiate()
		fireplace.add_child(fireplace_material)
	else:
		fireplace.remove_child(fireplace_material)
		fireplace_material.queue_free()
		fireplace_material = null
