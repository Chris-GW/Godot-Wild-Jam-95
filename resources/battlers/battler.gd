@tool
class_name Battler
extends Resource

@export
var name := "<battler>":
	set(value):
		name = value

		emit_changed()

@export
var health: Health:
	set(value):
		health = value

		SignalHelper.on_changed(health, emit_changed)

		emit_changed()

func take_damage(damage_resolver: NumberResolver) -> int:
	if health:
		var damage_dealt := health.take_damage(damage_resolver)
		return damage_dealt

	return 0

func is_dead() -> bool:
	return health and health.is_empty()

func has_mana_pool() -> bool:
	return false

func get_mana_pool() -> PointPool:
	return null

func has_mana(_amount_resolver: NumberResolver) -> bool:
	return false

func consume_mana(_amount_resolver: NumberResolver) -> void:
	pass
