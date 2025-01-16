extends Button
class_name MatchButton

@export var fireplace: BonfireFireplace
@export var matchbox_light_on_fire := preload("res://bonfire/matchbox_light_on_fire.tscn")
@onready var match_scene := preload("res://bonfire/match.tscn")

var _matchbox: MatchboxLightOnFire
var _match_item: BonfireMatch

signal match_created(match: BonfireMatch)

func _on_pressed() -> void:
	_matchbox = matchbox_light_on_fire.instantiate()
	_matchbox.global_position = fireplace.global_position
	_matchbox.connect("match_on_fire", _match_on_fire)
	fireplace.get_parent().add_child(_matchbox)
	fireplace.disable_all_selectables()
	disabled = true

func _match_on_fire() -> void:
	await get_tree().create_timer(0.5).timeout
	_matchbox.queue_free()
	_match_item = match_scene.instantiate()
	_match_item.global_position = fireplace.global_position
	fireplace.get_parent().add_child(_match_item)
	match_created.emit(_match_item)

func restart() -> void:
	button_pressed = false
	disabled = false
