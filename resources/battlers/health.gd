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

func take_damage(damage_resolver: NumberResolver) -> int:
	var old_health := current_health

	current_health -= int(damage_resolver.resolve())

	if current_health != old_health:
		CustomLogger.info("Health %d -> %d" % [old_health, current_health])
		current_health_changed.emit(current_health, old_health)

	return old_health - current_health

func heal(healing_resolver: NumberResolver) -> int:
	var old_health := current_health

	current_health += int(healing_resolver.resolve())

	if current_health != old_health:
		CustomLogger.info("Health %d -> %d" % [old_health, current_health])
		current_health_changed.emit(current_health, old_health)

	return current_health - old_health

func heal_fully() -> int:
	var healing_resolver := ConstantNumberResolver.new()
	healing_resolver.value = max_health - current_health

	return heal(healing_resolver)

func is_empty() -> bool:
	return current_health <= 0
