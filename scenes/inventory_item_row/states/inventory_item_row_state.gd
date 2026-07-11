class_name InventoryItemRowState
extends Node

signal state_transition_requested(new_state: InventoryItemRow.State, state_data: InventoryItemRowStateData)

var _inventory_item_row: InventoryItemRow = null
var _state_data: InventoryItemRowStateData = null
var _appearance: InventoryItemRowAppearance = null

func setup(
	inventory_item_row: InventoryItemRow,
	state_data: InventoryItemRowStateData,
	appearance: InventoryItemRowAppearance,
) -> void:
	_inventory_item_row = inventory_item_row
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: InventoryItemRow.State,
	state_data := InventoryItemRowStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func to_selected() -> void:
	pass

func to_idle() -> void:
	pass
