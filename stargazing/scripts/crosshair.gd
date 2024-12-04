extends Sprite2D



func _on_star_picker_logic_calibrated(factor: float) -> void:
	modulate = Color(0.5+factor*0.5, 0.5+factor*0.5, 1-factor*0.5, factor*0.9+0.1)
