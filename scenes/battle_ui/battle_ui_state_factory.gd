class_name BattleUIStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		BattleUI.State.HIDDEN: BattleUIStateHidden,
		BattleUI.State.SHOWN: BattleUIStateShown,
	}

func get_fresh_state(state: BattleUI.State) -> BattleUIState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
