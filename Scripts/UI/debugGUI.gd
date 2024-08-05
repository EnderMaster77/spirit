extends CanvasLayer

var tewet: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/Velocity.text = "Velocity: " + str($"..".velocity)
	$Panel/FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	#$Panel/mainMod.text = "Main Mod: " + str($"../SpriteManager/Main".get_modulate())
	#$Panel/transMod.text = "Trans Mod: " + str($"../SpriteManager/Transition_To".get_modulate())


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("showDebug"):
		visible = !visible
