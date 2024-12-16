extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@export var texture_array: Array[Texture2D]
@export var quicktime_game: TreeChopGame

var hit_counter: int = 0
var hits_to_win: int = 0

func _ready() -> void:
	sprite.texture = texture_array[hit_counter]	
	hits_to_win = texture_array.size() - 1

func _process(_delta: float) -> void:
	pass

func _on_quicktime_quicktime_finished(win: bool) -> void:
	if (win):
		hit_counter += 1
		await get_tree().create_timer(0.2).timeout
		sprite.texture = texture_array[hit_counter]	
	if (hit_counter == hits_to_win):
		await get_tree().create_timer(2.0).timeout
		quicktime_game.end_quicktime()
		return
	await get_tree().create_timer(1.0).timeout
	quicktime_game.restart_quicktime()
