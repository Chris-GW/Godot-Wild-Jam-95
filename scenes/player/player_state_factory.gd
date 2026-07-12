class_name PlayerStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		Player.State.PAUSED: PlayerStatePaused,
		Player.State.ACTIVE: PlayerStateActive,
	}

func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
