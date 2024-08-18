extends CanvasLayer

@export var player: CharacterBody2D
@export var playercam: Camera2D

var zoomcam: bool
var normal_zoom: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	normal_zoom = playercam.zoom.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PanelContainer/ItemList/pos.text = "Position: " + str(player.global_position)
	$PanelContainer/ItemList/vel.text = "Velocity: " + str(player.velocity)
	$PanelContainer/ItemList/fps.text = "FPS: " + str(Engine.get_frames_per_second())
	if zoomcam == true:
		playercam.limit_top = -999999999
		playercam.limit_bottom = 99999999
		playercam.limit_right = 99999999
		playercam.limit_left = -99999999
		playercam.zoom.x = $PanelContainer/ItemList/Zoom.value
		playercam.zoom.y = $PanelContainer/ItemList/Zoom.value
	$PanelContainer/ItemList/CamTop.text = str(playercam.limit_top)
	$PanelContainer/ItemList/CamBottom.text = str(playercam.limit_bottom)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("showDebug"):
		visible = !visible


func _on_check_box_2_toggled(toggled_on: bool) -> void:
	zoomcam = toggled_on

	if toggled_on == false:
		playercam.zoom.x = normal_zoom
		playercam.zoom.y = normal_zoom
