extends Control

signal opened
signal closed

var current_page: int = 0
var is_open: bool = false

@onready var pages: Array = $JournalBackground/Pages.get_children()

func _ready() -> void:
	for page: Control in pages:
		page.visible = false
	pages[current_page].visible = true

func _process(_delta):
	if Input.is_action_just_pressed("book"):
		if is_open:
			close()
		else:
			open()
	
func close():
	visible = false
	is_open = false
	closed.emit()

func open():
	visible = true
	is_open = true
	opened.emit()

func _on_left_button_pressed():
	if current_page > 0:
		pages[current_page].visible = false
		current_page = current_page - 1
		pages[current_page].visible = true
		

func _on_right_button_pressed():
	if current_page < len(pages)-1:
		pages[current_page].visible = false
		current_page = current_page + 1
		pages[current_page].visible = true
		
