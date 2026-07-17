class_name CreditsScreenStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		CreditsScreen.State.HIDDEN: CreditsScreenStateHidden,
		CreditsScreen.State.SHOWN: CreditsScreenStateShown,
	}

func get_fresh_state(state: CreditsScreen.State) -> CreditsScreenState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
