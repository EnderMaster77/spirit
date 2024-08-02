extends Node2D

#@onready var FXman: FXmanager = $"../FXman"
#var alpha_to: float = 0
#var enabled: bool = false
#var modA: float = 0
var using_controller: bool = false
signal switch_to_element

# File was massively re-written.

func _input(event: InputEvent) -> void:
     if event is InputEventJoypadButton or event is InputEventJoypadMotion:
          using_controller = true
     elif event is InputEventKey:
          using_controller = false
     if Input.is_action_just_pressed("switchToNeutral"):
          switch_to_element.emit("neutral")
     elif Input.is_action_just_pressed("switchToWater"):
          switch_to_element.emit("water")
     elif Input.is_action_just_pressed("switchToFire"):
          switch_to_element.emit("fire")
     elif Input.is_action_just_pressed("switchToLightning"):
          switch_to_element.emit("lightning")
     elif Input.is_action_just_pressed("switchToEarth"):
          switch_to_element.emit("earth")
