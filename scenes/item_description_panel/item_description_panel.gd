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
		label.text = item.description if item else "<item_description>"
