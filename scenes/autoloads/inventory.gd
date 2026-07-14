extends Node

var _item_pool: Array[Item] = [
	preload("res://resources/items/item_cassette.tres"),
	preload("res://resources/items/item_cdrom.tres"),
	preload("res://resources/items/item_vinyllp.tres"),
	preload("res://resources/items/item_gameboy.tres"),
	preload("res://resources/items/item_dialpadphone.tres"),
	preload("res://resources/items/item_vhs.tres"),
	preload("res://resources/items/item_mp3.tres"),
	preload("res://resources/items/item_fax.tres"),
	preload("res://resources/items/item_crttv.tres"),
]

var _items: Array[Item] = [
	preload("res://resources/items/item_cassette.tres"),
	preload("res://resources/items/item_dialpadphone.tres"),
	preload("res://resources/items/item_gameboy.tres"),
	preload("res://resources/items/item_mp3.tres"),
]

func _ready() -> void:
	SignalHelper.once_next_frame(_emit_changed)

func _process(_delta: float) -> void:
	if OS.has_feature("editor_runtime"):
		if Input.is_action_just_pressed("debug_add_random_item"):
			_add_random()

func _emit_changed() -> void:
	GameEvents.emit_inventory_changed(_items)

func get_item(index: int) -> Item:
	if index < 0 or index >= _items.size():
		return null

	return _items[index]

func add(item: Item) -> void:
	if not _items.has(item):
		_items.append(item)

		CustomLogger.info("Added %s to inventory" % item.name)

		_emit_changed()

func _add_random() -> void:
	var item: Item = _item_pool.pick_random()
	add(item)
