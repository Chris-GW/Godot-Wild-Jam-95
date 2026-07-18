extends Node

var _items: Array[Item] = [
	preload("res://resources/items/item_startingmoney.tres"),
]

func _ready() -> void:
	if OS.has_feature("editor_runtime"):
		_items.push_front(preload("res://resources/items/item_instakill.tres"))

	SignalHelper.once_next_frame(emit_changed)

func emit_changed() -> void:
	GameEvents.emit_inventory_changed(_items)

func get_item(index: int) -> Item:
	if index < 0 or index >= _items.size():
		return null

	return _items[index]

func add(item: Item) -> void:
	if not _items.has(item):
		_items.append(item)

		CustomLogger.info("Added %s to inventory" % item.name)

		emit_changed()
