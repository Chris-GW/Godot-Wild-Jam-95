@tool
class_name BattleUI
extends CanvasLayer

enum State { HIDDEN, SHOWN }

@onready
var appearance: BattleUIAppearance = %Appearance

var _state_factory := BattleUIStateFactory.new()
var _current_state: BattleUIState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(BattleUI.State.HIDDEN)

func switch_state(state: BattleUI.State, state_data := BattleUIStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "BattleUIStateMachine: %s" % str(state)
	
	assert(_current_state != null)
	call_deferred("add_child", _current_state)

func _refresh() -> void:
	pass
