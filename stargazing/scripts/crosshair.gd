extends Sprite2D

@export var idle_crosshair_modulation: float = 0.25

func _ready() -> void:
	_on_star_picker_logic_calibrated(0)

func _on_star_picker_logic_calibrated(factor: float) -> void:
	modulate = Color(0.5+factor*0.5, 0.5+factor*0.5, 1-factor*0.5, factor*(1-idle_crosshair_modulation)+idle_crosshair_modulation)
