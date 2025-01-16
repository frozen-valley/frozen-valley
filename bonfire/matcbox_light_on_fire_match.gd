extends Sprite2D

func set_flame_alpha(alpha: float) -> void:
	$Flame.self_modulate.a = alpha
