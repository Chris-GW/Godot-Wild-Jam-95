class_name BattleUIState
extends Node

signal state_transition_requested(new_state: BattleUI.State, state_data: BattleUIStateData)

var _battle_ui: BattleUI = null
var _state_data: BattleUIStateData = null
var _appearance: BattleUIAppearance = null

func setup(
	battle_ui: BattleUI,
	state_data: BattleUIStateData,
	appearance: BattleUIAppearance,
) -> void:
	_battle_ui = battle_ui
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: BattleUI.State,
	state_data := BattleUIStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
