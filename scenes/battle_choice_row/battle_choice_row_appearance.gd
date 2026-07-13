@tool
class_name BattleChoiceRowAppearance
extends Node

@export
var label: Label

@export
var pointer: TextureRect

func set_item(item: Item) -> void:
	if label:
		label.text = item.name if item else "<choice>"

func set_selected(selected: bool) -> void:
	if pointer:
		pointer.visible = selected

func for_selected() -> void:
	if pointer:
		pointer.show()

func for_idle() -> void:
	if pointer:
		pointer.hide()
