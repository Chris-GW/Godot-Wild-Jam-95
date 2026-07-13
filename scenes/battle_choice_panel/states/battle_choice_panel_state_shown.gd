class_name BattleChoicePanelStateShown
extends BattleChoicePanelState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now shown" % _battle_choice_panel.name)

	_appearance.for_shown()

	var items := Loadout.get_items()

	_appearance.set_choices(items)
	_list_menu_interaction.set_maximum(items.size() - 1)

	_appearance.set_selected_index(_list_menu_interaction.current())

	SignalHelper.once(
		GameEvents.player_attack_chosen,
		_on_player_attack_chosen)

	SignalHelper.persist(
		_list_menu_interaction.index_changed,
		_on_index_changed)

	GameEvents.emit_inventory_shown()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("choose_player_attack"):
		GameEvents.emit_player_attack_chosen(_list_menu_interaction.current())

	_list_menu_interaction.check()

func _on_player_attack_chosen(_index: int) -> void:
		transition_state(BattleChoicePanel.State.HIDDEN)

func _on_index_changed(index: int) -> void:
	_appearance.set_selected_index(index)
