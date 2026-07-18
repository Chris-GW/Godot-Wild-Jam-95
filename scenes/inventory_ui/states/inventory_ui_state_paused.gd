class_name InventoryUIStatePaused
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now paused" % _inventory_ui.name)

	_appearance.for_paused()

	SignalHelper.persist(
		GameEvents.inventory_changed,
		_on_inventory_changed)

	SignalHelper.persist(
		GameEvents.encounter_ended,
		_on_encounter_ended)

func _on_inventory_changed(items: Array[Item]) -> void:
	_list_menu_interaction.set_maximum(items.size() - 1)

	_appearance.set_items(items, _list_menu_interaction.current())

func _on_encounter_ended() -> void:
	transition_state(InventoryUI.State.HIDDEN)
