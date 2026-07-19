extends Node

var _completed_encounters: Array[Encounter] = []


func _ready() -> void:
	if OS.is_debug_build():
		skip_game_parts_chirs_debug()


func skip_game_parts_chirs_debug() -> void:
	if not OS.is_debug_build():
		return
	PlayerManager.prologue_wakeup = false
	PlayerManager.prologue_has_game = true
	PlayerManager.is_back_home = true
	
	complete(load("res://resources/encounters/encounter_crttv.tres"))
	complete(load("res://resources/encounters/encounter_mp3_player.tres"))
	complete(load("res://resources/encounters/encounter_fax_machine.tres"))
	#complete(load("res://resources/encounters/encounter_dial_pad_phone.tres"))
	
	await get_tree().process_frame
	#GameEvents.emit_map_transition_requested("res://scenes/maps/new_player_home.tscn", "%ExitPlayerHome")
	#GameEvents.emit_map_transition_requested("res://scenes/maps/cave_map.tscn", "%ExitCave")
	#GameEvents.emit_map_transition_requested("res://scenes/maps/map_03.tscn", "%ExitOffice")
	return


func complete(encounter: Encounter) -> void:
	if not _completed_encounters.has(encounter):
		_completed_encounters.append(encounter)

func is_available(encounter: Encounter) -> bool:
	if _completed_encounters.has(encounter):
		return false

	if encounter.prerequisites.is_empty():
		return true

	return encounter.prerequisites.all(is_complete)

func is_complete(encounter: Encounter) -> bool:
	return _completed_encounters.has(encounter)
