class_name InventoryUIStatePaused
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now paused" % _inventory_ui.name)

	_appearance.for_paused()

	SignalHelper.persist(
		GameEvents.encounter_ended,
		_on_encounter_ended)

func _on_encounter_ended() -> void:
	transition_state(InventoryUI.State.HIDDEN)
