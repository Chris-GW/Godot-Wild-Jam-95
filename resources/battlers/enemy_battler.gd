@tool
class_name EnemyBattler
extends Battler

@export
var id := -1:
	set(value):
		id = value

		emit_changed()

@export_multiline
var description := "<description>":
	set(value):
		description = value

		emit_changed()

@export
var battle_effect: BattleEffect:
	set(value):
		battle_effect = value

		emit_changed()
