class_name InventoryUIStateHidden
extends InventoryUIState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now hidden" % _inventory_ui.name)

	_appearance.for_hidden()

	SignalHelper.persist(
		GameEvents.inventory_changed,
		_on_inventory_changed)

	SignalHelper.persist(
		GameEvents.battle_started,
		_on_battle_started)

	GameEvents.emit_inventory_hidden()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		SoundManager.play_inventory_open()

		transition_state(InventoryUI.State.SHOWN)

func _on_inventory_changed(items: Array[Item]) -> void:
	_list_menu_interaction.set_maximum(items.size() - 1)

	_appearance.set_items(items, _list_menu_interaction.current())

func _on_battle_started() -> void:
	transition_state(InventoryUI.State.PAUSED)
