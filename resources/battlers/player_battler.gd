@tool
class_name PlayerBattler
extends Battler

@export
var mana_pool: PointPool:
	set(value):
		mana_pool = value

		SignalHelper.on_changed(mana_pool, emit_changed)

		emit_changed()

func has_mana_pool() -> bool:
	return true

func get_mana_pool() -> PointPool:
	return mana_pool

func has_mana(amount_resolver: NumberResolver) -> bool:
	return mana_pool and mana_pool.has_minimum(amount_resolver)

func consume_mana(amount_resolver: NumberResolver) -> void:
	if mana_pool:
		mana_pool.consume(amount_resolver)

func reset_mana() -> void:
	if mana_pool:
		mana_pool.reset_fully()
