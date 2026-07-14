extends Node

const ITEM_LIMIT := 4

var _equipped_items: Array[Item] = [
	preload("res://resources/items/item_cassette.tres"),
	preload("res://resources/items/item_dialpadphone.tres"),
	preload("res://resources/items/item_gameboy.tres"),
	preload("res://resources/items/item_mp3.tres"),
]

func _ready() -> void:
	SignalHelper.once_next_frame(_emit_changed)

func _emit_changed() -> void:
	GameEvents.emit_loadout_changed(_equipped_items)

func get_items() -> Array[Item]:
	return _equipped_items

func get_item(index: int) -> Item:
	if index < 0 or index >= _equipped_items.size():
		return null

	return _equipped_items[index]

func equip(item: Item) -> void:
	if not _equipped_items.has(item):
		_equipped_items.append(item)

		CustomLogger.info("Added %s to loadout" % item.name)

		if _equipped_items.size() > ITEM_LIMIT:
			var removed_item: Item = _equipped_items.pop_front()

			CustomLogger.info("Removed %s from loadout" % removed_item.name)

		_emit_changed()
	else:
		CustomLogger.info("Already have %s in loadout!" % item.name)

func is_equipped(item: Item) -> bool:
	return _equipped_items.has(item)
