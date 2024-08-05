extends CanvasLayer
class_name FXmanager

var isBlurring: bool = false
var isUnblurring: bool = false


func blur():
	isBlurring = true
	$blur.show()


func unblur():
	isBlurring = false
	isUnblurring = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isBlurring == true:
		var blurFX = $blur.material
		blurFX.set_shader_parameter(
			"strength", lerpf(blurFX.get_shader_parameter("strength"), 0.8, delta * 12)
		)
		if blurFX.get_shader_parameter("strength") >= 0.8:
			isBlurring = false
	if isUnblurring == true:
		var blurFX = $blur.material
		blurFX.set_shader_parameter(
			"strength", lerpf(blurFX.get_shader_parameter("strength"), 0.0, delta * 12)
		)
		if blurFX.get_shader_parameter("strength") <= 0.01:
			isUnblurring = false
			$blur.hide()
