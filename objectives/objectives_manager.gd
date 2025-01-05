extends Control
class_name ObjectivesManager

@export var objective: Objective
@onready var label_preload = preload("res://objectives/ObjectiveLabel.tscn")

@onready var container: VBoxContainer = $ObjectivesContainer

var solved: Array[bool] = []
var task_labels: Array[Label] = []


func _ready():
	for task in objective.tasks:
		solved.append(false)
		var new_label: Label = label_preload.instantiate()
		new_label.text = "    - " + task
		container.add_child(new_label)
		task_labels.append(new_label)
		

func solve(index: int = -1):
	if index == -1:
		index += 1
		while index<len(solved) and solved[index]:
			index += 1
		if index >= len(solved):
			printerr("All objectives are already solved!")
			return
		solved[index] = true
		task_labels[index].modulate = Color(0.25, 1, 0.25, 0.25)
	else:
		if solved[index]:
			printerr("Objective '" + objective.tasks[index] + "' is already solved!")
			return
		else:
			solved[index] = true
			task_labels[index].modulate = Color(0.25, 1, 0.25, 0.25)


func _on_button_pressed() -> void:
	solve()
