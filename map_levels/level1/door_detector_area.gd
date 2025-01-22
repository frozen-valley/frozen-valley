extends Area2D

@export var player: Player 
@export var inventory: Inventory
@export var key_item: Pickupable
var player_is_at_door: bool = false



func _process(delta):
	var interact: bool = Input.is_action_just_pressed("interact")
	if (interact && player_is_at_door):
		#inventory.remove(key_item.item)
		if (player.inventory.has_item("key")):
			get_parent().get_node("AudioStreamPlayer2D").play()
			await Signal(get_parent().get_node("AudioStreamPlayer2D"), 'finished')			
			get_parent().queue_free()
			get_parent().get_parent().get_node("HouseArea").process_mode = Node.PROCESS_MODE_INHERIT

		else:
			# Dialog
			print("Maybe there's a key around here somewhere")


func _on_body_entered(body):
	player_is_at_door = true
	



func _on_body_exited(body):
	player_is_at_door = false
	
