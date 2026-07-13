class_name BattleChoiceRowStateSelected
extends BattleChoiceRowState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now selected" % _battle_choice_row.name)

	_appearance.for_selected()

func to_idle() -> void:
	transition_state(BattleChoiceRow.State.IDLE)
