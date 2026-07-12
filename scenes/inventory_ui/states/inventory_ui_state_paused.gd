class_name InventoryUIStatePaused
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now paused" % _inventory_ui.name)

	_appearance.for_paused()

	SignalHelper.persist(
		GameEvents.battle_ended,
		transition_state.bind(InventoryUI.State.HIDDEN))
