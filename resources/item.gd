@tool
class_name Item
extends Resource

enum ItemClass { BASIC, MAGIC }

@export
var id := -1:
	set(value):
		id = value

		emit_changed()

@export
var name := "<item>":
	set(value):
		name = value

		emit_changed()

@export
var item_class := ItemClass.BASIC:
	set(value):
		item_class = value

		emit_changed()

@export
var battle_effect: BattleEffect:
	set(value):
		battle_effect = value

		emit_changed()

@export
var mana_cost := 0:
	set(value):
		mana_cost = value

		emit_changed()

@export_multiline
var description := "<description>":
	set(value):
		description = value

		emit_changed()
