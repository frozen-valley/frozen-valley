extends StaticBody2D
class_name DeadTree

signal play_minigame
signal minigame_solved

@export var player: Player 
@export var distance_treshold: float = 300

var distance: float = 0
var did_quicktime := false

var tree_chop_node
var world_node
var main_node

func play_quicktime() -> void:
	play_minigame.emit()
	
func _on_finished_quicktime() -> void:
	minigame_solved.emit()
	did_quicktime = true

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
			

var seen = false
func _on_notice_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	var player_body = body as Player
	if (!player_body):
		return
	if not seen:
		seen = true
		Dialogic.Inputs.auto_advance.enabled_forced = true
		Dialogic.start("sad_tree")
