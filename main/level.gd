extends Node
class_name Level

signal done

func finish():
	done.emit()
