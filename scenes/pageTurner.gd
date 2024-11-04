extends Control

var current_page = 1
var is_open = false

func _process(delta):
	if Input.is_action_just_pressed("book"):
		if is_open:
			close()
		else:
			open()
	
func close():
	visible = false
	is_open = false

func open():
	visible = true
	is_open = true

func _on_left_button_pressed():
	if current_page != 1:
		current_page = current_page - 1
		changePage()

func _on_right_button_pressed():
	if current_page != 3:
		current_page = current_page + 1
		changePage()


func changePage():
	match current_page:
		1:
			$LeftPage/Sprite2D.texture = ResourceLoader.load("res://sprites/pageOnePlaceholder.png")
			$RightPage/Sprite2D.texture = ResourceLoader.load("res://sprites/pageOnePlaceholder.png")
		2:
			$LeftPage/Sprite2D.texture = ResourceLoader.load("res://sprites/pageTwoPlaceholder.png")
			$RightPage/Sprite2D.texture = ResourceLoader.load("res://sprites/pageTwoPlaceholder.png")
		3:
			$LeftPage/Sprite2D.texture = ResourceLoader.load("res://sprites/pageThreePlaceholder.png")
			$RightPage/Sprite2D.texture = ResourceLoader.load("res://sprites/pageThreePlaceholder.png")
