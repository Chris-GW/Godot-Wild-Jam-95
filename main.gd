extends Node2D

func _ready() -> void:
	SignalHelper.once_next_frame(Inventory.emit_changed)
	SignalHelper.once_next_frame(Loadout.emit_changed)
