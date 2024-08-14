extends Sprite2D

func _process(delta: float) -> void:
	if 2 % floor(delta) == 0:
		print(delta)
