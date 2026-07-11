class_name InventoryUIStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		InventoryUI.State.HIDDEN: InventoryUIStateHidden,
		InventoryUI.State.SHOWN: InventoryUIStateShown,
	}

func get_fresh_state(state: InventoryUI.State) -> InventoryUIState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
