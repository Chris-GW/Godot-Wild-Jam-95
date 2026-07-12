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

		emit_changed()

func take_damage(damage_resolver: NumberResolver) -> int:
	if health:
		var damage_dealt := health.take_damage(damage_resolver)
		return damage_dealt

	return 0

func is_dead() -> bool:
	return health and health.is_empty()
