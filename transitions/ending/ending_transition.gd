extends Transition

@onready var credits: Label = $Credits
@onready var title_screen: Sprite2D = $TitleScreen



func _ready() -> void:
	super()
	Dialogic.Inputs.auto_advance.enabled_forced = true
	Dialogic.Inputs.auto_advance.fixed_delay = 3
	get_tree().create_timer(1).timeout.connect(after_1_sec)
	get_tree().create_timer(17).timeout.connect(show_title_screen)
	get_tree().create_timer(22).timeout.connect(show_credits)
	get_tree().create_timer(35).timeout.connect(change_scene)

func after_1_sec():
	Dialogic.start("ending")

func show_title_screen():
	title_screen.visible = true

func show_credits():
	credits.visible = true

func change_scene():
	get_tree().change_scene_to_file("res://main/main.tscn")
	


	
