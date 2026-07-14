@tool
class_name ItemDescriptionPanel
extends PanelContainer

@export
var item: Item:
	set(value):
		item = value

		SignalHelper.on_changed(item, _refresh)

		_refresh()

@export
var show_equip_hint := false:
	set(value):
		show_equip_hint = value

		SignalHelper.on_changed(item, _refresh)

		_refresh()

@onready
var label: Label = %Label

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if label:
		label.text = _compute_text()

func _compute_text() -> String:
	if not item:
		return "<item_description>"

	if not show_equip_hint:
		return item.description

	if not Engine.is_editor_hint() and Loadout.is_equipped(item):
		return item.description + " (equipped)"

	return item.description + " (Space to equip)"

func set_loadout_items(_items: Array[Item]) -> void:
	_refresh()
