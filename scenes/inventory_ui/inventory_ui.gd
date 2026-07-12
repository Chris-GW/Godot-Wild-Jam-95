@tool
class_name InventoryUI
extends CanvasLayer

enum State { HIDDEN, SHOWN, PAUSED }

@export
var selected_index := -1:
	set(value):
		selected_index = value

		_refresh()

@onready
var appearance: InventoryUIAppearance = %Appearance

var _state_factory := InventoryUIStateFactory.new()
var _current_state: InventoryUIState = null

var _selected_index_tracker := IndexTracker.new(0, "InventorySelectedIndex")

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(InventoryUI.State.HIDDEN)

func switch_state(state: InventoryUI.State, state_data := InventoryUIStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		_selected_index_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "InventoryUIStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_selected_index(selected_index)
