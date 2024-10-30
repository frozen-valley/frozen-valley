extends Node2D

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("play_matchbox")):
		var root_node = get_tree().get_root()
		var scene_node = root_node.get_node("World")
		scene_node.queue_free()

		var new_scene_resource = load("res://matchbox_game/matchbox_game.tscn") 
		var new_scene_node = new_scene_resource.instantiate() 
		root_node.add_child(new_scene_node)

