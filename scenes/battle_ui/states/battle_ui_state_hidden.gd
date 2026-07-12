class_name BattleUIStateHidden
extends BattleUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now hidden" % _battle_ui.name)

	_appearance.for_hidden()

	SignalHelper.once(
		GameEvents.battle_started,
		_on_battle_started)

func _on_battle_started() -> void:
	_appearance.clear_battle_text()
	transition_state(BattleUI.State.SHOWN)
