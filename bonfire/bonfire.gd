extends Level
class_name BonfireGame

@export var fireplace: BonfireFireplace
@export var matches: MatchButton

func _ready() -> void:
	Dialogic.start("bonfire_intro")
	Dialogic.signal_event.connect(start_game)
	matches.connect("match_created", _match_created)

func start_game(arg):
	if arg == "start_bonfire":
		$Materials.visible = true
	else:
		printerr("Unknown signal fired: " + arg)

func _on_matches_placed_down() -> void:
	finish()


func _match_created(match_item: BonfireMatch) -> void:
	print("yea majmune")
	match_item.connect("match_placed", _match_placed)

func _match_placed():
	print("placed")

func _on_matches_pressed() -> void:
	$Materials.visible = false
