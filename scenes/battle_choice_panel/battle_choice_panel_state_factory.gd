class_name BattleChoicePanelStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		BattleChoicePanel.State.HIDDEN: BattleChoicePanelStateHidden,
		BattleChoicePanel.State.SHOWN: BattleChoicePanelStateShown,
	}

func get_fresh_state(state: BattleChoicePanel.State) -> BattleChoicePanelState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
