extends Node

signal game_started

signal inventory_shown
signal inventory_hidden

signal inventory_changed(items: Array[Item])
signal loadout_changed(items: Array[Item])

signal map_transition_requested(map_scene_path: String, enter_node_name: String)

signal enemy_chasing(enemy_entity: EnemyEntity)
signal battle_started
signal battle_ended(is_won: bool)
signal battle_text_created(text: String)

signal enemy_effect_resolved(effect: BattleEffect)
signal player_attack_requested
signal player_attack_considered(index: int)
signal player_attack_chosen(index: int)

signal reward_gained(item: Item)
signal encounter_ended

func emit_game_started() -> void:
	game_started.emit()

func emit_inventory_shown() -> void:
	inventory_shown.emit()

func emit_inventory_hidden() -> void:
	inventory_hidden.emit()

func emit_inventory_changed(items: Array[Item]) -> void:
	inventory_changed.emit(items)

func emit_loadout_changed(items: Array[Item]) -> void:
	loadout_changed.emit(items)

func emit_map_transition_requested(map_scene_path: String, enter_node_name: String = "") -> void:
	map_transition_requested.emit(map_scene_path, enter_node_name)

func emit_enemy_chasing(enemy_entity: EnemyEntity) -> void:
	enemy_chasing.emit(enemy_entity)

func emit_battle_started() -> void:
	battle_started.emit()

func emit_battle_ended(is_won: bool) -> void:
	battle_ended.emit(is_won)

func emit_battle_text_created(text: String) -> void:
	battle_text_created.emit(text)

func emit_enemy_effect_resolved(effect: BattleEffect) -> void:
	enemy_effect_resolved.emit(effect)

func emit_player_attack_requested() -> void:
	player_attack_requested.emit()

func emit_player_attack_considered(index: int) -> void:
	player_attack_considered.emit(index)

func emit_player_attack_chosen(index: int) -> void:
	player_attack_chosen.emit(index)

func emit_reward_gained(item: Item) -> void:
	reward_gained.emit(item)

func emit_encounter_ended() -> void:
	encounter_ended.emit()
