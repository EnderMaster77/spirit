## A MetSysModule that handles room transitions.
##
## The module connects to [signal MetroidvaniaSystem.room_changed]. When room changes, the new scene gets is loaded via [code]load_room()[/code] method. If MetSysGame has a player set, the player will be automatically teleported to the correct entrance.
extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysModule.gd"

var player: Node2D
var fadeinanim: CanvasLayer
func _initialize():
	player = game.player
	for i in player.get_children():
		if i.has_method("fadein"):
			fadeinanim = i
	assert(player)
	MetSys.room_changed.connect(_on_room_changed, CONNECT_DEFERRED)

func _on_room_changed(target_room: String):
	# Hours wasted on the fadeout animation:
	# [6]
	if target_room == MetSys.get_current_room_name():
		# This can happen when teleporting to another room.
		return
	fadeinanim.fading_in = true
	player.get_tree().paused =true
	while fadeinanim.alpha < 1:
		player.get_tree().paused =true
		await player.get_tree().create_timer(0.05).timeout
	var prev_room_instance := MetSys.get_current_room_instance()
	if prev_room_instance:
		prev_room_instance.get_parent().remove_child(prev_room_instance)

	await game.load_room(target_room)
	player.get_tree().paused =false
	if prev_room_instance:
		player.position -= MetSys.get_current_room_instance().get_room_position_offset(prev_room_instance)
		# This solution comepletely avoids the problem. The problem still exists, but it's just harder to cause.
		if player.position.x > MetSys.get_current_room_instance().get_size().x/2:
			player.global_position.x -= 20
		else:
			player.global_position.x += 20
		prev_room_instance.queue_free()
	player.get_tree().paused =false
	fadeinanim.fading_out = true
