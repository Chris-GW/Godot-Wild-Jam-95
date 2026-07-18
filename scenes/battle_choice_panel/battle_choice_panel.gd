@tool
class_name BattleChoicePanel
extends PanelContainer

enum State { HIDDEN, SHOWN }

@onready
var appearance: BattleChoicePanelAppearance = %Appearance

@onready
var list_menu_interaction: ListMenuInteraction = %ListMenuInteraction

var _state_factory := BattleChoicePanelStateFactory.new()
var _current_state: BattleChoicePanelState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	list_menu_interaction.set_tracker_name("BattleChoicePanelSelectedIndex")

	switch_state(BattleChoicePanel.State.HIDDEN)

func switch_state(state: BattleChoicePanel.State, state_data := BattleChoicePanelStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		list_menu_interaction)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "BattleChoicePanelStateMachine: %s" % str(state)

	assert(_current_state != null)
	call_deferred("add_child", _current_state)

func _refresh() -> void:
	pass
