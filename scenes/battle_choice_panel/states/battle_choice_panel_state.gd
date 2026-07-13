class_name BattleChoicePanelState
extends Node

signal state_transition_requested(new_state: BattleChoicePanel.State, state_data: BattleChoicePanelStateData)

var _battle_choice_panel: BattleChoicePanel = null
var _state_data: BattleChoicePanelStateData = null
var _appearance: BattleChoicePanelAppearance = null
var _list_menu_interaction: ListMenuInteraction = null

func setup(
	battle_choice_panel: BattleChoicePanel,
	state_data: BattleChoicePanelStateData,
	appearance: BattleChoicePanelAppearance,
	list_menu_interaction: ListMenuInteraction,
) -> void:
	_battle_choice_panel = battle_choice_panel
	_state_data = state_data
	_appearance = appearance
	_list_menu_interaction = list_menu_interaction

func transition_state(
	new_state: BattleChoicePanel.State,
	state_data := BattleChoicePanelStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
