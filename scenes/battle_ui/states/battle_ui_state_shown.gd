class_name BattleUIStateShown
extends BattleUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now shown" % _battle_ui.name)

	_appearance.for_shown()
	_appearance.set_enemy(BattleManager.get_current().enemy)

	SignalHelper.persist(
		GameEvents.player_attack_requested,
		_on_player_attack_requested)

	SignalHelper.persist(
		GameEvents.player_attack_considered,
		_on_player_attack_considered)

	SignalHelper.persist(
		GameEvents.player_attack_chosen,
		_on_player_attack_chosen)

	SignalHelper.once(
		GameEvents.battle_ended,
		_on_battle_ended)

	SignalHelper.persist(
		GameEvents.battle_text_created,
		_on_battle_text_created)

func _on_player_attack_requested() -> void:
	_appearance.for_player_attack_requested()

func _on_player_attack_considered(index: int) -> void:
	_appearance.set_attack_considered(index)

func _on_player_attack_chosen(_index: int) -> void:
	_appearance.for_player_attack_chosen()

func _on_battle_ended(_is_won: bool) -> void:
	transition_state(BattleUI.State.HIDDEN)

func _on_battle_text_created(text: String) -> void:
	_appearance.add_battle_text(text)
