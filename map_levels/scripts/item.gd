@tool

extends Area2D
class_name Pickupable

var follow_player := false
var player: Player

var seen = false

@export var item: InventoryItem

func _ready():
	$Sprite2D.texture = item.texture

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		$Sprite2D.texture = item.texture
		return
	if (follow_player):
		var new_pos := Vector2(player.position.x, player.position.y - 135)
		set_global_position(new_pos)

func pick_me_up(player_ref: Player) -> void:
	player = player_ref
	follow_player = true
	$AudioStreamPlayer2D.play()
	z_index = 100
	await get_tree().create_timer(1.2).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	var player_body = body as Player
	if (!player_body):
		return
	player_body.add_to_pickup_queue(self)
	
	if not seen:
		seen = true
		Dialogic.Inputs.auto_advance.enabled_forced = true
		Dialogic.start("little_sister_found_something")


func _on_body_exited(body: Node2D) -> void:
	var player_body = body as Player
	if (!player_body):
		return
	player_body.remove_from_pickup_queue(self)
