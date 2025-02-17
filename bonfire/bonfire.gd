extends Level
class_name BonfireGame

@export var fireplace: BonfireFireplace
@export var matches: MatchButton

func _ready() -> void:
	Dialogic.start("bonfire_intro")
	Dialogic.signal_event.connect(start_game)
	matches.connect("match_created", _match_created)
	fireplace.connect("fireplace_finished", _fireplace_finished)

func start_game(arg):
	if arg == "start_bonfire":
		$Materials.visible = true
	else:
		printerr("Unknown signal fired: " + arg)

func _match_created(match_item: BonfireMatch) -> void:
	match_item.connect("match_placed", _match_placed)

func _match_placed():
	# Currently unused
	pass

func _on_matches_pressed() -> void:
	$Materials.visible = false

func _fireplace_finished(win: bool):
	if (win):
		finish()
		return

	fireplace.restart()
	matches.restart()
	$Materials.visible = true
	for child: Control in $Materials.get_children():
		if child is MaterialButton:
			child.restart()
