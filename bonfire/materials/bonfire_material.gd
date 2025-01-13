extends Selectable
class_name Flammable

## Controls the level of flammability. The lower the flammability, the longer it burns.
## Flammable with flammability x sets every Flammable with flammability <= x+1 on fire.
@export var flammability: int 
var _active := false

func set_sprite(sprite: Texture2D) -> void:
	$Sprite2D.texture = sprite

func _ready() -> void:
	super()
	scale = Vector2(0.5, 0.5)

func _process(_delta: float) -> void:
	super(_delta)
	pass
	# Fire simulation	
	# TODO

func put_on_fire() -> void:
	_active = false
