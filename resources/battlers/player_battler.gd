@tool
class_name PlayerBattler
extends Battler

@export
var mana_pool: PointPool

func has_mana(amount_resolver: NumberResolver) -> bool:
	return mana_pool and mana_pool.has_minimum(amount_resolver)

func consume_mana(amount_resolver: NumberResolver) -> void:
	if mana_pool:
		mana_pool.consume(amount_resolver)
