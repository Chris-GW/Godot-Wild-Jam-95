class_name InventoryUIStateHidden
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now hidden" % _inventory_ui.name)

	_appearance.for_hidden()

	SignalHelper.persist(
		GameEvents.inventory_changed,
		_on_inventory_changed)

	GameEvents.emit_inventory_hidden()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		transition_state(InventoryUI.State.SHOWN)

	if Input.is_action_just_pressed("start_example_battle"):
		BattleManager.start_example_battle()
		transition_state(InventoryUI.State.PAUSED)

func _on_inventory_changed(items: Array[Item]) -> void:
	_selected_index_tracker.set_maximum(items.size() - 1)

	_appearance.set_items(items, _selected_index_tracker.current())
