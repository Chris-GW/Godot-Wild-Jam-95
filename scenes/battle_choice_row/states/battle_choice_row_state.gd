class_name BattleChoiceRowState
extends Node

signal state_transition_requested(new_state: BattleChoiceRow.State, state_data: BattleChoiceRowStateData)

var _battle_choice_row: BattleChoiceRow = null
var _state_data: BattleChoiceRowStateData = null
var _appearance: BattleChoiceRowAppearance = null

func setup(
	battle_choice_row: BattleChoiceRow,
	state_data: BattleChoiceRowStateData,
	appearance: BattleChoiceRowAppearance,
) -> void:
	_battle_choice_row = battle_choice_row
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: BattleChoiceRow.State,
	state_data := BattleChoiceRowStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func to_selected() -> void:
	pass

func to_idle() -> void:
	pass
