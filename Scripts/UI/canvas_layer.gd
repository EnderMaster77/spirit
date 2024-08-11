extends CanvasLayer

@export var player: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PanelContainer/ItemList/pos.text = "Position: " + str(player.global_position)
	$PanelContainer/ItemList/vel.text = "Velocity: " + str(player.velocity)
	$PanelContainer/ItemList/fps.text = "FPS: " + str(Engine.get_frames_per_second())

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("showDebug"):
		visible = !visible
