@tool
class_name BattleChoiceRow
extends Control

enum State { IDLE, SELECTED }

@export
var item: Item:
	set(value):
		item = value

		_refresh()

@export
var selected := false:
	set(value):
		selected = value

		_refresh()

@onready
var appearance: BattleChoiceRowAppearance = %Appearance

var _state_factory := BattleChoiceRowStateFactory.new()
var _current_state: BattleChoiceRowState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(BattleChoiceRow.State.IDLE)

func switch_state(state: BattleChoiceRow.State, state_data := BattleChoiceRowStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "BattleChoiceRowStateMachine: %s" % str(state)

	assert(_current_state != null)
	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_item(item)

		if Engine.is_editor_hint():
			if selected:
				appearance.for_selected()
			else:
				appearance.for_idle()

func to_selected() -> void:
	if Engine.is_editor_hint():
		if appearance:
			appearance.for_selected()
	elif _current_state:
		_current_state.to_selected()

func to_idle() -> void:
	if Engine.is_editor_hint():
		if appearance:
			appearance.for_idle()
	elif _current_state:
		_current_state.to_idle()
