class_name InventoryUIStatePaused
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now paused" % _inventory_ui.name)

	_appearance.for_paused()

	SignalHelper.persist(
		GameEvents.battle_ended,
		_on_battle_ended)

func _on_battle_ended(_is_won: bool) -> void:
	transition_state(InventoryUI.State.HIDDEN)
