extends Node3D

var stargazing_tree_preload := preload("res://stargazing/sub_scenes/stargazing_tree.tscn")

func _ready() -> void:
	
	for i in range(200):
		var tree_instance: StargazingTree = stargazing_tree_preload.instantiate()
		
		var rand_angle := randf_range(0, 2*PI)
		var position_up := randf_range(-20, 20)
		var rand_dist := randf_range(200, 1000)
		var rand_scale := randf_range(10, 25)
		
		tree_instance.position = Vector3.RIGHT.rotated(Vector3.UP, rand_angle) * rand_dist + Vector3.UP * position_up
		add_child(tree_instance)
		
		tree_instance.scale = Vector3.ONE * rand_scale
		
		tree_instance.adjust_rotation()
