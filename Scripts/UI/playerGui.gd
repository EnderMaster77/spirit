extends CanvasLayer

var fading_out : bool = false
var fading_in : bool = false
var alpha: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out == true:
		fading_in = false
		$fadeout.color.a = lerpf($fadeout.color.a, 0, delta * 16)
		if $fadeout.color.a <= 0.05:
			$fadeout.color.a = 0
			fading_out = false
		alpha = $fadeout.color.a
	if fading_in == true:
		fading_out = false
		$fadeout.color.a = lerpf($fadeout.color.a, 1, delta * 16)
		if $fadeout.color.a >= 0.95:
			fading_in = false
			$fadeout.color.a = 1
		alpha = $fadeout.color.a
	$fadeout.color.a = alpha


func fadein():
	return
