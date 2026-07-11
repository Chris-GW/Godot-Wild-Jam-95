extends Node

const ITEM_LIMIT := 4

var _equipped_items: Array[Item] = []

func equip(item: Item) -> void:
	if not _equipped_items.has(item):
		_equipped_items.append(item)

		CustomLogger.info("Added %s to loadout" % item.name)

		if _equipped_items.size() > ITEM_LIMIT:
			var removed_item: Item = _equipped_items.pop_front()

			CustomLogger.info("Removed %s from loadout" % removed_item.name)

		GameEvents.emit_loadout_changed(_equipped_items)
	else:
		CustomLogger.info("Already have %s in loadout!" % item.name)

func is_equipped(item: Item) -> bool:
	return _equipped_items.has(item)
