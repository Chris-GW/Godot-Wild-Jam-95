@tool
class_name InventoryUIAppearance
extends Node

@export
var base_control: Control

@export
var empty_label: Label

@export
var rows_parent: VBoxContainer

@export
var description_panel: ItemDescriptionPanel

var _rows: Array[InventoryItemRow] = []

func _ready() -> void:
	for c: InventoryItemRow in rows_parent.get_children():
		_rows.append(c)

func set_items(items: Array[Item], selected_index: int) -> void:
	if items.size() <= 0:
		empty_label.show()
		rows_parent.hide()
	else:
		empty_label.hide()
		rows_parent.show()

	for i in _rows.size():
		if items.size() > i:
			_rows[i].item = items[i]
			_rows[i].show()
		else:
			_rows[i].item = null
			_rows[i].hide()

	if description_panel:
		if items.size() > 0 and selected_index >= 0:
			description_panel.item = items[selected_index]
			description_panel.show()
		else:
			description_panel.item = null
			description_panel.hide()

func set_loadout_items(items: Array[Item]) -> void:
	for i in _rows.size():
		if items.has(_rows[i].item):
			_rows[i].show_equipped()
		else:
			_rows[i].show_equippable()

	if description_panel:
		description_panel.set_loadout_items(items)

func set_selected_index(index: int) -> void:
	var selected_item: Item

	for i in _rows.size():
		if index == i:
			_rows[i].to_selected()
			selected_item = _rows[i].item
		else:
			_rows[i].to_idle()

	if description_panel:
		description_panel.item = selected_item

func for_shown() -> void:
	if base_control:
		base_control.show()

func for_hidden() -> void:
	if base_control:
		base_control.hide()

func for_paused() -> void:
	if base_control:
		base_control.hide()
