extends Node

signal inventory_changed(items: Array[Item])
signal loadout_changed(items: Array[Item])

signal map_transition_requested(map_scene_path: String, enter_node_name: String)

signal player_attack_chosen(index: int)

func emit_inventory_changed(items: Array[Item]) -> void:
	inventory_changed.emit(items)

func emit_loadout_changed(items: Array[Item]) -> void:
	loadout_changed.emit(items)

func emit_map_transition_requested(map_scene_path: String, enter_node_name: String) -> void:
	map_transition_requested.emit(map_scene_path, enter_node_name)

func emit_player_attack_chosen(index: int) -> void:
	player_attack_chosen.emit(index)
