extends Node

signal inventory_shown
signal inventory_hidden

signal inventory_changed(items: Array[Item])
signal loadout_changed(items: Array[Item])

signal map_transition_requested(map_scene_path: String, enter_node_name: String)

signal battle_started
signal battle_ended
signal battle_text_created(text: String)
signal player_attack_chosen(index: int)

func emit_inventory_shown() -> void:
	inventory_shown.emit()

func emit_inventory_hidden() -> void:
	inventory_hidden.emit()

func emit_inventory_changed(items: Array[Item]) -> void:
	inventory_changed.emit(items)

func emit_loadout_changed(items: Array[Item]) -> void:
	loadout_changed.emit(items)

func emit_map_transition_requested(map_scene_path: String, enter_node_name: String) -> void:
	map_transition_requested.emit(map_scene_path, enter_node_name)

func emit_battle_started() -> void:
	battle_started.emit()

func emit_battle_ended() -> void:
	battle_ended.emit()

func emit_battle_text_created(text: String) -> void:
	battle_text_created.emit(text)

func emit_player_attack_chosen(index: int) -> void:
	player_attack_chosen.emit(index)
