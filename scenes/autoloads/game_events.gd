extends Node

signal inventory_changed(items: Array[Item])
signal loadout_changed(items: Array[Item])

func emit_inventory_changed(items: Array[Item]) -> void:
	inventory_changed.emit(items)

func emit_loadout_changed(items: Array[Item]) -> void:
	loadout_changed.emit(items)
