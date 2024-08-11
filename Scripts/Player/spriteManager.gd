extends Node2D
#@onready var main_mat: ShaderMaterial = $Main.material

@onready var main: Sprite2D = $Main
@onready var trans: Sprite2D

var target_progress: float = 2.0

@onready var firetrans: ShaderMaterial = load("res://Shaders/ShaderMaterials/firetransition.tres")
@onready
var neutraltrans: ShaderMaterial = load("res://Shaders/ShaderMaterials/neutraltransition.tres")

var transitioning: bool = false

var element: String = "neutral"

signal switch_to_element
# Switch to element after transition ends.
#var element_in_queue: String = ""

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_method(element + "_transition") == true && transitioning == true:
		# Should probably add a failsafe for if the function doesn't exist.
		call(element + "_transition", delta)


func neutral_transition(delta: float):
	# If code below is not ran
	if main.material == null:
		return
	main.material.set_shader_parameter(
		"progress", lerpf(main.material.get_shader_parameter("progress"), 5, delta * 6)
	)
	if main.material.get_shader_parameter("progress") >= target_progress:
		make_main()
		transitioning = false


func water_transition(delta: float):
	print("w")
	make_main()
	transitioning = false


func fire_transition(delta: float):
	if main.material == null:
		return
	print("f")
	main.material.set_shader_parameter(
		"progress", lerpf(main.material.get_shader_parameter("progress"), 2, delta * 8)
	)
	if main.material.get_shader_parameter("progress") >= target_progress:
		make_main()
		transitioning = false


func earth_transition(delta: float):
	print("e")
	make_main()
	transitioning = false


func lightning_transition(delta: float):
	print("l")
	make_main()
	transitioning = false


func make_main():
	if main.material != null:
		main.material.set_shader_parameter("progress", target_progress)
	main.hide()
	main.queue_free()
	main.material = null
	main = trans
	main.material = null
	main.z_index = 1


func _on_switch_to_element(state: String) -> void:
	if transitioning == true:
		return
	switch_to_element.emit(state)
	# Visual changes handled here.
	# For mechanical changes, use the sprite main player script.
	if state == element:
		return
	match state:
		"neutral":
			element = "neutral"
			trans = generate_sprite2d("res://icon.svg", Color(1, 1, 1, 1))
			trans.show()
			trans.modulate = Color(1, 1, 1, 1)
			main.set_material(neutraltrans)
			main.material.set_shader_parameter("progress", -1)
			target_progress = 2.9
		"water":
			element = "water"
			trans = generate_sprite2d("res://icon.svg", Color(0, 0, 1, 1))
		"fire":
			element = "fire"
			trans = generate_sprite2d("res://icon.svg", Color(1, 0, 0, 1))
			main.set_material(firetrans)
			main.material.set_shader_parameter("progress", -1)
			target_progress = 1.7
		"earth":
			element = "earth"
			trans = generate_sprite2d("res://icon.svg", Color(0, 1, 0, 1))

		"lightning":
			element = "lightning"
			trans = generate_sprite2d("res://icon.svg", Color(1, 1, 0, 1))
	transitioning = true


func generate_sprite2d(texture_path: String, mod: Color = Color(1, 1, 1, 1)) -> Sprite2D:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = load(texture_path)
	sprite.modulate = mod
	z_index = -1
	sprite.show()
	add_child(sprite)
	return sprite
