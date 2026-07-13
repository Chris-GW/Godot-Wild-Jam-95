class_name BattleChoiceRowStateIdle
extends BattleChoiceRowState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now idle" % _battle_choice_row.name)

	_appearance.for_idle()

func to_selected() -> void:
	transition_state(BattleChoiceRow.State.SELECTED)
