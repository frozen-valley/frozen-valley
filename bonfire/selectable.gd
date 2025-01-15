extends Area2D
class_name Selectable

### All selectables should have a common parent!

signal selection_toggled(selection)

var _selected := false
var _top_most := false

var _mouse_over := false
var _mouse_offset: Vector2

var selectable_active := true

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	selection_toggled.connect(_on_selected)

func _input(event: InputEvent) -> void:
	if (!selectable_active):
		return

	if (!_mouse_over):
		return
	if (event is InputEventMouseButton && event.button_index == 1):
		if (event.is_pressed()):
			_mouse_offset = get_global_mouse_position() - global_position
			set_selected(true)
		else:
			set_selected(false)

func _process(_delta: float) -> void:
	if (!selectable_active):
		return

	if (!get_overlapping_areas().is_empty()):
		for entity: Area2D in get_overlapping_areas():
			var my_index = get_index()
			var your_index = entity.get_index()
			if (my_index < your_index):
				_top_most = false
			else:
				_top_most = true
	
	if (_selected):
		global_position = get_global_mouse_position()

## Checks if any other nodes which are on top of this one are already selected
## Returns `true` when the material is the top most material or the only material that the mouse is over, `false` otherwise
func _check_if_shold_select_me() -> bool:
	var nodes: Array[Node] = get_tree().get_nodes_in_group("selected")
	if (nodes.is_empty()):
		return true
	else:
		return _top_most

func set_selected(selection: bool) -> void:
	if (selection):
		# Checks if this material should be selected 
		if (!_check_if_shold_select_me()):
			return
		# Make the material exclusive in the group	
		get_tree().call_group("selected", "set_selected", false);
		add_to_group("selected")
		# Move it so it is the top most one now
		get_parent().move_child(self, get_parent().get_child_count() - 1);
	else:
		if (is_in_group("selected")):
			remove_from_group("selected")
	
	_selected = selection
	emit_signal("selection_toggled", _selected)

func _on_mouse_entered():
	_mouse_over = true

func _on_mouse_exited():
	_mouse_over = false

func _on_selected(selection: bool):
	# Currently unused but might be useful (e.g. show an outline on the selected material)
	if (selection):	
		print("selected")
	else:
		print("unselected")

