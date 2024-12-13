extends StaticBody2D
class_name DeadTree

@export var player: Player 
@export var distance_treshold: float = 300
var distance: float = 0
var did_quicktime := false

var root_node: Window
var world_node: Node2D
var tree_chop_node: QuicktimeGame

func _on_finished_quicktime() -> void:
	did_quicktime = true
	tree_chop_node.queue_free()
	root_node.add_child(world_node)
	var log_and_stump_resource := load("res://scenes/log_and_stump.tscn") 
	var log_and_stump_node = log_and_stump_resource.instantiate()
	log_and_stump_node.position = position
	world_node.add_child(log_and_stump_node)
	self.queue_free()

func play_quicktime() -> void:
	root_node.remove_child(world_node)
	var tree_chop_resource := load("res://tree_chop_game/tree_chop_game.tscn") 
	tree_chop_node = tree_chop_resource.instantiate() 	
	tree_chop_node.finished_quicktime.connect(_on_finished_quicktime)
	root_node.add_child(tree_chop_node)

func _ready() -> void:
	root_node = get_tree().get_root()
	world_node = root_node.get_node("World")
	if (!player):
		queue_free()

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
			
