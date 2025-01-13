extends Button

@export var fireplace: Control
@onready var material_sprite = preload("res://bonfire/sprite_for_material.tscn")
@onready var match_sprite = preload("res://bonfire/match.tscn")

var instance
var spawned = false
var duration = 0

func _on_pressed() -> void:
	spawn()

func spawn():
	spawned = true
	instance = material_sprite.instantiate()
	fireplace.add_child(instance)
	duration = 0.2

func despawn():
	if not spawned:
		return
	spawned = false
	instance.queue_free()

func _process(delta: float) -> void:
	if spawned:
		if duration < 0:
			despawn()
		duration -= delta
