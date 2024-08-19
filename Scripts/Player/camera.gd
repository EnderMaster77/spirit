extends Camera2D
class_name CameraPlus

@export var player: CharacterBody2D
var target_limit_bottom: int = 1440
var state
enum CameraState {
	FREE = 0,
	CENTERING = 1,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player == null:
		player = get_parent()
	state = CameraState.FREE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(state)
	handle_x_offset(delta)
	handle_y_limits(delta)



func handle_x_offset(delta: float):
	if player.velocity.x == 0:
		return
	position.x += player.velocity.x * delta /2
	position.x = clampf(position.x, -300, 300)

func handle_y_limits(delta:float):
	if MetSys.get_current_room_instance() == null:
		return
	if player.global_position.x >= MetSys.get_current_room_instance().get_size().x - 250\
	or player.global_position.x <=250:
		if state == CameraState.FREE && limit_bottom != round((global_position.y/1440)+0.5) * 1440:
			limit_bottom = ((get_viewport_rect().size.y/2)/ zoom.y) + global_position.y
			state = CameraState.CENTERING
		limit_bottom = int(lerpf(limit_bottom,round((global_position.y/1440)+0.5) * 1440,delta *16))#round((global_position.y/1440)+0.5) * 1440
		print("LB: ",limit_bottom)
		return
	state = CameraState.FREE
	if limit_bottom <=((get_viewport_rect().size.y/2)/ zoom.y) + global_position.y &&\
	limit_bottom < target_limit_bottom:
		limit_bottom = int(lerpf(limit_bottom,((get_viewport_rect().size.y/2)/ zoom.y) + global_position.y,delta * 8))
		return
	limit_bottom = target_limit_bottom
