@tool
class_name Health
extends Resource

@export
var max_health := 50:
	set(value):
		max_health = maxi(value, 0)

		if current_health > max_health:
			current_health = max_health

		emit_changed()

@export
var current_health := 50:
	set(value):
		current_health = clampi(value, 0, max_health)

		emit_changed()

signal current_health_changed(new_health: int, old_health: int)

func take_damage(damage_resolver: NumberResolver) -> void:
	var old_health := current_health

	current_health -= int(damage_resolver.resolve())

	if current_health != old_health:
		CustomLogger.info("Health %d -> %d" % [old_health, current_health])
		current_health_changed.emit(current_health, old_health)

func is_empty() -> bool:
	return current_health <= 0
