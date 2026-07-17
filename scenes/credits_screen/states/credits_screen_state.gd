class_name CreditsScreenState
extends Node

signal state_transition_requested(new_state: CreditsScreen.State, state_data: CreditsScreenStateData)

var _credits_screen: CreditsScreen = null
var _state_data: CreditsScreenStateData = null
var _appearance: CreditsScreenAppearance = null

func setup(
	credits_screen: CreditsScreen,
	state_data: CreditsScreenStateData,
	appearance: CreditsScreenAppearance,
) -> void:
	_credits_screen = credits_screen
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: CreditsScreen.State,
	state_data := CreditsScreenStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func is_shown() -> bool:
	return false
