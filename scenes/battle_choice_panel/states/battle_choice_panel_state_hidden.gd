class_name BattleChoicePanelStateHidden
extends BattleChoicePanelState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now hidden" % _battle_choice_panel.name)

	_appearance.for_hidden()

	SignalHelper.once(
		GameEvents.player_attack_requested,
		transition_state.bind(BattleChoicePanel.State.SHOWN))
