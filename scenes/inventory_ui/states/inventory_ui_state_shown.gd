class_name InventoryUIStateShown
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now shown" % _inventory_ui.name)

	_appearance.for_shown()

	SignalHelper.persist(
		GameEvents.inventory_changed,
		_on_inventory_changed)

	SignalHelper.persist(
		GameEvents.loadout_changed,
		_on_loadout_changed)

	GameEvents.emit_inventory_shown()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		transition_state(InventoryUI.State.HIDDEN)

	if Input.is_action_just_pressed("toggle_equip"):
		Loadout.equip(Inventory.get_item(_selected_index_tracker.current()))

	if Input.is_action_just_pressed("move_up"):
		var new_index := _selected_index_tracker.previous()
		_appearance.set_selected_index(new_index)

	if Input.is_action_just_pressed("move_down"):
		var new_index := _selected_index_tracker.next()
		_appearance.set_selected_index(new_index)

func _on_inventory_changed(items: Array[Item]) -> void:
	_selected_index_tracker.set_maximum(items.size() - 1)

	_appearance.set_items(items, _selected_index_tracker.current())

func _on_loadout_changed(items: Array[Item]) -> void:
	_appearance.set_loadout_items(items)
