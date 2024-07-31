extends Node2D
#@onready var main_mat: ShaderMaterial = $Main.material
@onready var main: Sprite2D = $Main
@onready var trans: Sprite2D = $Transition_To

@onready var firetrans: ShaderMaterial = load("res://Shaders/ShaderMaterials/firetransition.tres")
@onready var neutraltrans: ShaderMaterial = load("res://Shaders/ShaderMaterials/neutraltransition.tres")


var transitioning: bool = false

var element: String = "neutral"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if transitioning == true:
		# Should probably add a failsafe for if the function doesn't exist.
		call(element + "_transition", delta)

func neutral_transition(delta: float):
	main.material.set_shader_parameter("progress",\
	lerpf(main.material.get_shader_parameter("progress"),\
	5,\
	delta * 6))
	if main.material.get_shader_parameter("progress") >= 3.97:
		make_main()
		transitioning = false
	
func water_transition(delta: float):
	print("w")
	make_main()
	transitioning = false

func fire_transition(delta: float):
	print("f")
	main.material.set_shader_parameter("progress",\
	lerpf(main.material.get_shader_parameter("progress"),\
	2,\
	delta * 8))
	if main.material.get_shader_parameter("progress") >= 1.95:
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
	main.set_texture(trans.get_texture())
	main.modulate = trans.modulate
	main.set_material(trans.get_material())
	#trans.hide()


func _on_switch_to_element(state: int) -> void:
	print(state)
	if transitioning == true:
		make_main()
		transitioning = false
	# Visual changes handled here.
	# For mechanical changes, use the sprite main player script.
	match state:
		0:
			if element == "neutral":
				return
			element = "neutral"
			transitioning = true
			trans.show()
			trans.modulate = Color(1,1,1,1)
			main.set_material(neutraltrans)
			main.material.set_shader_parameter("progress",-0.5)
		1:
			if element == "water":
				return
			element = "water"
			trans.show()
			transitioning = true
			trans.modulate = Color(0,0,1,1)
		2:
			if element == "fire":
				return
			element = "fire"
			#modulate = Color(1,0,0,1)
			transitioning = true
			trans.show()
			trans.modulate = Color(1,0,0,1)
			main.set_material(firetrans)
			main.material.set_shader_parameter("progress",-1)
			#main.set_mate
		3:
			if element == "earth":
				return
			element = "earth"
			transitioning = true
			trans.show()
			trans.modulate = Color(0,1,0,1)
			
		4:
			if element == "lightning":
				return
			element = "lightning"
			transitioning = true
			trans.show()
			trans.modulate = "ffff00"
