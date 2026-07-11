class_name InventoryItemRowStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		InventoryItemRow.State.IDLE: InventoryItemRowStateIdle,
		InventoryItemRow.State.SELECTED: InventoryItemRowStateSelected,
	}

func get_fresh_state(state: InventoryItemRow.State) -> InventoryItemRowState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
