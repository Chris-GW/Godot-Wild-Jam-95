extends Node

var _equipped_items: Array[Item] = []

func _ready() -> void:
	SignalHelper.persist(
		GameEvents.inventory_changed,
		_on_inventory_changed)

	SignalHelper.once_next_frame(emit_changed)

func _on_inventory_changed(items: Array[Item]) -> void:
	_equipped_items = items

func emit_changed() -> void:
	GameEvents.emit_loadout_changed(_equipped_items)

func get_items() -> Array[Item]:
	return _equipped_items

func get_item(index: int) -> Item:
	if index < 0 or index >= _equipped_items.size():
		return null

	return _equipped_items[index]

func is_equipped(item: Item) -> bool:
	return _equipped_items.has(item)
