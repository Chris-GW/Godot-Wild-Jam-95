class_name InventoryItemRowStateIdle
extends InventoryItemRowState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now idle" % _inventory_item_row.name)

	_appearance.for_idle()

func to_selected() -> void:
	transition_state(InventoryItemRow.State.SELECTED)
