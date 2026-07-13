class_name BattleChoiceRowStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		BattleChoiceRow.State.IDLE: BattleChoiceRowStateIdle,
		BattleChoiceRow.State.SELECTED: BattleChoiceRowStateSelected,
	}

func get_fresh_state(state: BattleChoiceRow.State) -> BattleChoiceRowState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
