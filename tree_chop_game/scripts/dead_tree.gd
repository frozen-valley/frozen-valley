extends StaticBody2D
class_name DeadTree

signal play_minigame
signal minigame_solved

@export var player: Player 
@export var distance_treshold: float = 300

var distance: float = 0
var did_quicktime := false

var tree_chop_node: QuicktimeGame
var world_node
var main_node

func play_quicktime() -> void:
	play_minigame.emit()
	var tree_chop_resource := load("res://tree_chop_game/tree_chop_game.tscn") 
	return
	tree_chop_node = tree_chop_resource.instantiate() 	
	tree_chop_node.finished_quicktime.connect(_on_finished_quicktime)
	main_node.add_child(tree_chop_node)
	world_node.visible = false
	
func _on_finished_quicktime() -> void:
	minigame_solved.emit()
	did_quicktime = true
	var log_and_stump_resource := load("res://map/sub_scenes/log_and_stump.tscn") 
	var log_and_stump_node = log_and_stump_resource.instantiate()
	log_and_stump_node.position = position
	log_and_stump_node.scale.x *= -1
	return
	tree_chop_node.queue_free()
	world_node.visible = true
	world_node.add_child(log_and_stump_node)
	self.queue_free()

func _ready() -> void:
	world_node = get_parent().get_parent()
	main_node = world_node.get_parent()

	if (!player):
		printerr("There's no player!")

func _process(_delta: float) -> void:
	distance = global_position.distance_to(player.global_position)

	if (distance >= distance_treshold):
		return
	if (did_quicktime):
		return

	var interact: bool = Input.is_action_just_pressed("interact")
	if (interact):
		if (player.inventory.has_item("axe")):
			play_quicktime()
		else:
			# Dialog
			print("I could use an axe")
			
