class_name InventoryUIState
extends Node

signal state_transition_requested(new_state: InventoryUI.State, state_data: InventoryUIStateData)

var _inventory_ui: InventoryUI = null
var _state_data: InventoryUIStateData = null
var _appearance: InventoryUIAppearance = null
var _list_menu_interaction: ListMenuInteraction = null

func setup(
	inventory_ui: InventoryUI,
	state_data: InventoryUIStateData,
	appearance: InventoryUIAppearance,
	list_menu_interaction: ListMenuInteraction,
) -> void:
	_inventory_ui = inventory_ui
	_state_data = state_data
	_appearance = appearance
	_list_menu_interaction = list_menu_interaction

func transition_state(
	new_state: InventoryUI.State,
	state_data := InventoryUIStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
