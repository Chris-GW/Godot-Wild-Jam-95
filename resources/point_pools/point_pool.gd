@tool
class_name PointPool
extends Resource

@export
var max_points := 20:
	set(value):
		max_points = maxi(value, 0)

		if current_points > max_points:
			current_points = max_points

		emit_changed()

@export
var current_points := 20:
	set(value):
		current_points = clampi(value, 0, max_points)

		emit_changed()

signal current_points_changed(new_points: int, old_points: int)

func has_minimum(amount_resolver: NumberResolver) -> bool:
	return current_points >= int(amount_resolver.resolve())

func consume(amount_resolver: NumberResolver) -> int:
	var old_points := current_points

	current_points -= int(amount_resolver.resolve())

	if current_points != old_points:
		CustomLogger.info("Points %d -> %d" % [old_points, current_points])
		current_points_changed.emit(current_points, old_points)

	return old_points - current_points

func reset_fully() -> int:
	var old_points := current_points

	current_points = max_points

	if current_points != old_points:
		CustomLogger.info("Points %d -> %d" % [old_points, current_points])
		current_points_changed.emit(current_points, old_points)

	return current_points - old_points

func is_empty() -> bool:
	return current_points <= 0
