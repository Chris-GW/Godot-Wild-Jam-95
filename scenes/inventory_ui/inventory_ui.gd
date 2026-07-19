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

@onready
var list_menu_interaction: ListMenuInteraction = %ListMenuInteraction

var _state_factory := InventoryUIStateFactory.new()
var _current_state: InventoryUIState = null

func _ready() -> void:
	if Engine.is_editor_hint():
		_refresh()
		return

	# calling _refresh() immediately at the start of this _ready() method was
	# causing a crash - CrashHandlerException: Program crashed with signal 11
	SignalHelper.once_next_frame(_refresh)

	list_menu_interaction.set_tracker_name("InventorySelectedIndex")

	switch_state(InventoryUI.State.HIDDEN)

func switch_state(state: InventoryUI.State, state_data := InventoryUIStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		list_menu_interaction)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "InventoryUIStateMachine: %s" % str(state)

	assert(_current_state != null)
	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_selected_index(selected_index)
