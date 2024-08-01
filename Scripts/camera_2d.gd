extends Camera2D

@onready var player: CharacterBody2D = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.velocity)
	offset = lerp(offset, player.velocity, delta * 4)
