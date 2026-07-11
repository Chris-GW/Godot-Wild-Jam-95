@tool
class_name ItemDescriptionPanel
extends PanelContainer

@export
var item: Item:
	set(value):
		item = value

		SignalHelper.on_changed(item, _refresh)

		_refresh()

@onready
var label: Label = %Label

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if label:
		if item:
			if not Engine.is_editor_hint() and Loadout.is_equipped(item):
				label.text = item.description + " (equipped)"
			else:
				label.text = item.description + " (Space to equip)"
		else:
			label.text = "<item_description>"

func set_loadout_items(_items: Array[Item]) -> void:
	_refresh()
