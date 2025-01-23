extends Level

@onready var treechop_minigame = preload("res://tree_chop_game/tree_chop_game.tscn")

func _on_cross_river_button_pressed() -> void:
	finish()

var tree_chop
var tree_chopped = false
func _ready() -> void:
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.start("level1_intro")

func _on_dead_tree_play_minigame() -> void:
	if tree_chopped:
		return
	$NavigationRegion2D/Player/Camera2D.enabled = false
	tree_chop = treechop_minigame.instantiate()
	add_child(tree_chop)
	tree_chop.connect("done", _on_tree_chopped)
	$CanvasLayer/Inventory_UI.disable()
	$CanvasLayer/Level1Objectives.hide()

func _on_tree_chopped() -> void:
	$NavigationRegion2D/Player/Camera2D.enabled = true
	remove_child(tree_chop)
	tree_chop.queue_free()
	tree_chop = null
	do_solved_minigame()
	$CanvasLayer/Inventory_UI.enable()
	$CanvasLayer/Level1Objectives/ObjectivesManager.solve(7)
	$CanvasLayer/Level1Objectives.show()
	tree_chopped = true
	

func do_solved_minigame():
	var log_and_stump_resource := load("res://map_levels/sub_scenes/log_and_stump.tscn") 
	var log_and_stump_node = log_and_stump_resource.instantiate()
	log_and_stump_node.position = $NavigationRegion2D/DeadTree.position
	log_and_stump_node.scale.x *= -1
	log_and_stump_node.scale *= 1.5
	add_child(log_and_stump_node)
	$NavigationRegion2D/DeadTree.queue_free()
