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

func take_damage(damage_resolver: NumberResolver) -> void:
	if health:
		health.take_damage(damage_resolver)
