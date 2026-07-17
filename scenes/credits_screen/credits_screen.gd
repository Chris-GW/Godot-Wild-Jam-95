class_name CreditsScreen
extends Control

enum State { HIDDEN, SHOWN }

@onready
var appearance: CreditsScreenAppearance = %Appearance

var _state_factory := CreditsScreenStateFactory.new()
var _current_state: CreditsScreenState = null

func _ready() -> void:
	switch_state(CreditsScreen.State.HIDDEN)

func switch_state(state: CreditsScreen.State, state_data := CreditsScreenStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CreditsScreenStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func is_shown() -> bool:
	return _current_state and _current_state.is_shown()
