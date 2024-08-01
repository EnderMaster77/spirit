extends Node2D

@onready var FXman: FXmanager = $"../FXman"
var alpha_to: float = 0
var enabled: bool = false
var modA: float = 0
var cooled_down: bool = true
signal switch_to_element


func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("switchElement"):
		switch_to_element.emit(
			get_closest_to_mouse($CanvasLayer.get_children()).element_to_switch_to
		)
		disable()


func _ready() -> void:
	for child: Node2D in $CanvasLayer.get_children():
		child.modulate.a = modA
	alpha_to = -1


func enable() -> void:
	if cooled_down == false:
		return
	FXman.blur()
	modA = 0
	alpha_to = 1
	for child: Node2D in $CanvasLayer.get_children():
		child.modulate.a = modA
	show()




func disable():
	$"../Timer".start()
	cooled_down = false
	FXman.unblur()
	alpha_to = -1


func _process(delta: float) -> void:
	modA = lerpf(modA, alpha_to * 1.5, delta * 16)
	modA = clampf(modA, 0, 1)
	if modA == 0:
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	for child: Node2D in $CanvasLayer.get_children():
		child.modulate.a = modA
		if child.scale != Vector2.ONE:
			child.scale = lerp(child.scale, Vector2.ONE, delta * 4)

	var closest_to_mouse = get_closest_to_mouse($CanvasLayer.get_children())
	if closest_to_mouse.scale != Vector2(2, 2):
		closest_to_mouse.scale = lerp(closest_to_mouse.scale, Vector2(2, 2), delta * 4)


func get_closest_to_mouse(nodes: Array):  # Nodes is array with node2Ds.
	var least_distance: float = 9999
	var closest_node: Node2D
	for node in nodes:
		if typeof(node) != 24:
			continue
		var distance: float = node.position.distance_to(
			$CanvasLayer.get_viewport().get_mouse_position()
		)

		if distance < least_distance:
			least_distance = distance
			closest_node = node
	return closest_node


func _on_timer_timeout() -> void:
	print("Hello World!")
	cooled_down = true
