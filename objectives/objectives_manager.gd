extends Control
class_name ObjectivesManager

signal all_solved

@export var objective: Objective
@export var unsolved_task_color: Color = Color(0.75, 0.75, 1, 1)
@export var solved_task_color: Color = Color(0.75, 0.75, 1, 0.25)

@onready var label_preload = preload("res://objectives/ObjectiveLabel.tscn")
@onready var container: VBoxContainer = $ObjectivesContainer


var solved: Array[bool] = []
var task_labels: Array[Label] = []

var task_count: int:
	get:
		return len(objective.tasks)

var solve_count: int:
	get:
		return solved.count(true)

func _ready():
	hide()
	for task in objective.tasks:
		solved.append(false)
		var new_label: Label = label_preload.instantiate()
		new_label.text = "    - " + task
		container.add_child(new_label)
		task_labels.append(new_label)
		new_label.modulate = unsolved_task_color
		if objective.sequential:
			new_label.hide()
	task_labels[0].show()

func start():
	show()

func solve(index: int = -1):
	if objective.sequential:
		if index != -1:
			printerr("Cannot solve an indexed task in a sequential objective.")
			return
		index += 1
		while index<len(solved) and solved[index]:
			index += 1
		if index >= len(solved):
			printerr("All objectives are already solved!")
			return
		solved[index] = true
		task_labels[index].modulate = solved_task_color
		if index+1 < len(task_labels):
			task_labels[index+1].show()
		else:
			all_solved.emit()
	else:
		if index == -1:
			printerr("Tasks need to be solved by index in a non-sequential objective.")
		elif solved[index]:
			printerr("Objective '" + objective.tasks[index] + "' is already solved!")
		else:
			solved[index] = true
			task_labels[index].modulate = solved_task_color
		if solve_count == task_count:
			all_solved.emit()
