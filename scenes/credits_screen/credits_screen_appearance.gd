class_name CreditsScreenAppearance
extends Node

const SCROLL_SPEED := 3.0

@export
var base_control: Control

@export
var tab_container: TabContainer

@export
var scroll_container: ScrollContainer

func for_hidden() -> void:
	if base_control:
		base_control.hide()

func for_shown() -> void:
	if base_control:
		base_control.show()

	if tab_container:
		tab_container.current_tab = 0

	if scroll_container:
		scroll_container.scroll_vertical = 0

func previous_tab() -> void:
	if tab_container:
		tab_container.select_previous_available()

func next_tab() -> void:
	if tab_container:
		tab_container.select_next_available()

func can_scroll() -> bool:
	return scroll_container and scroll_container.is_visible_in_tree()

func scroll_by(scroll_amount: float) -> void:
	if can_scroll():
		scroll_container.scroll_vertical += int(SCROLL_SPEED * scroll_amount)
