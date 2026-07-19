extends Node2D


func _ready() -> void:
	SignalHelper.once_next_frame(Inventory.emit_changed)
	SignalHelper.once_next_frame(Loadout.emit_changed)
	#skip_game_parts_chirs_debug()


func skip_game_parts_chirs_debug() -> void:
	if not OS.is_debug_build():
		return
	PlayerManager.prologue_wakeup = false
	PlayerManager.prologue_has_game = true
	PlayerManager.is_back_home = true
	
	await get_tree().process_frame
	#GameEvents.emit_map_transition_requested("res://scenes/maps/new_player_home.tscn", "%ExitPlayerHome")
	#GameEvents.emit_map_transition_requested("res://scenes/maps/cave_map.tscn", "%ExitCave")
	#GameEvents.emit_map_transition_requested("res://scenes/maps/map_03.tscn", "%ExitOffice")
	return
