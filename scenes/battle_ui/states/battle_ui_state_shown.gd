class_name BattleUIStateShown
extends BattleUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now shown" % _battle_ui.name)

	_appearance.for_shown()
	_appearance.set_enemy(BattleManager.get_current().enemy)

	SignalHelper.once(
		GameEvents.player_attack_requested,
		_on_player_attack_requested)

	SignalHelper.once(
		GameEvents.battle_ended,
		transition_state.bind(BattleUI.State.HIDDEN))

	SignalHelper.persist(
		GameEvents.battle_text_created,
		_on_battle_text_created)

func _on_player_attack_requested() -> void:
	_appearance.show_player_panel()

func _on_battle_text_created(text: String) -> void:
	_appearance.add_battle_text(text)
