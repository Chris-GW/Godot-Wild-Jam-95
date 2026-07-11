class_name InventoryItemRowStateSelected
extends InventoryItemRowState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now selected" % _inventory_item_row.name)

	_appearance.for_selected()

func to_idle() -> void:
	transition_state(InventoryItemRow.State.IDLE)
