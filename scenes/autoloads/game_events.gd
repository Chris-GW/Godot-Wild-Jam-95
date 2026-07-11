extends Node

signal inventory_changed(items: Array[Item])

func emit_inventory_changed(items: Array[Item]) -> void:
	inventory_changed.emit(items)
