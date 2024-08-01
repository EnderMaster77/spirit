extends CharacterBody2D

const MAX_SPEED: float = 1000.0
const ACCEL_SPEED: float = 2250
const JUMP_VELOCITY: float = -400.0
const DEFAULT_FRICTION: float = 5000
var friction: float

@onready var Fxman: FXmanager = $FXman

#signal switch_to_element
#signal switch_to_state

var element: String
var current_state: String

@onready var cam = $Camera2D


func _ready() -> void:
	friction = DEFAULT_FRICTION
	element = "neutral"


func _process(delta: float) -> void:
	mod_camera(delta)


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	# Calls the current element's Movement function automatically.
	call(element + "_movement", direction, delta)

	move_and_slide()


func _input(event: InputEvent) -> void:
	# For things that don't need to be ran every frame or are tied to phyisics.
	if Input.is_action_just_pressed("switchElement"):
		$ElementSwitchGui.process_mode = Node.PROCESS_MODE_ALWAYS
		$ElementSwitchGui.enable()

		#get_tree().paused = true


func neutral_movement(direction: float, delta: float) -> void:
	# Y axis Control
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	# X axis Control
	# Decel
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		return
	# Accel
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCEL_SPEED * delta)
	if sign(velocity.x) != sign(direction):
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction, friction * delta)


func water_movement(direction: float, delta: float) -> void:
	# Y axis Control
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.x = JUMP_VELOCITY

	# X axis Control
	# Decel
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		return
	# Accel
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCEL_SPEED * delta)
	if sign(velocity.x) != sign(direction):
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction, friction * delta)



func fire_movement(direction: float, delta: float) -> void:
	# Y axis Control
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	# X axis Control
	# Decel
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		return
	# Accel
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCEL_SPEED * delta)
	if sign(velocity.x) != sign(direction):
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction, friction * delta)


func earth_movement(direction: float, delta: float) -> void:
	# Y axis Control
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	# X axis Control
	# Decel
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		return
	# Accel
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCEL_SPEED * delta)
	if sign(velocity.x) != sign(direction):
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction, friction * delta)


func lightning_movement(direction: float, delta: float) -> void:
	# Y axis Control
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	# X axis Control
	# Decel
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		return
	# Accel
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction * 1.5, ACCEL_SPEED * delta * 1.25)
	if sign(velocity.x) != sign(direction):
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction, friction * delta)


func mod_camera(delta: float):
	cam.offset = lerp(cam.offset, velocity / 2, delta * 4)
	#cam.offset.x = move_toward(cam.offset.x,velocity.x /2,MAX_SPEED * delta * 3)
	#cam.offset.y = move_toward(cam.offset.y,velocity.y /2,MAX_SPEED * delta * 3)
	#if abs(cam.offset.y) > abs(velocity.y /3):
	#	cam.offset.y == velocity.y /3


func _on_switch_to_element(state: int) -> void:
	print(state)
	# Mechanical changes handled here.
	# For visual changes, use the sprite manager.
	match state:
		0:
			element = "neutral"
		1:
			element = "water"
		2:
			element = "fire"
		3:
			element = "earth"
		4:
			element = "lightning"


func _on_switch_to_state(state: int) -> void:
	match state:
		0:
			current_state = "default"
		1:
			current_state = "swimming"
		2:
			current_state = "attacking"


func _on_hitbox_collision(area: Node2D) -> void:
	if area.get_collision_layer_value(4) == true:
		pass
