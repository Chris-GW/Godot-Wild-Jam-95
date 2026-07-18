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

	SignalHelper.persist(
		_list_menu_interaction.index_changed,
		_on_index_changed)

	GameEvents.emit_inventory_shown()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		transition_state(InventoryUI.State.HIDDEN)

	if Input.is_action_just_pressed("toggle_equip"):
		var item := Inventory.get_item(_list_menu_interaction.current())
		var did_equip := Loadout.equip(item)
		if did_equip:
			SoundManager.play_menu_select()

	_list_menu_interaction.check()

func _on_inventory_changed(items: Array[Item]) -> void:
	_list_menu_interaction.set_maximum(items.size() - 1)

	_appearance.set_items(items, _list_menu_interaction.current())

func _on_loadout_changed(items: Array[Item]) -> void:
	_appearance.set_loadout_items(items)

func _on_index_changed(index: int) -> void:
	_appearance.set_selected_index(index)

	SoundManager.play_menu_up_down()
