class_name MinimumManaRequirement
extends EffectRequirement

@export
var battler_resolver: BattlerResolver

@export
var amount_resolver: NumberResolver

func is_satisfied(battle: Battle) -> bool:
	var battler := battler_resolver.resolve(battle)
	return battler.has_mana(amount_resolver)

func apply(battle: Battle) -> void:
	var battler := battler_resolver.resolve(battle)
	battler.consume_mana(amount_resolver)

func get_failed_text(battle: Battle) -> String:
	var battler := battler_resolver.resolve(battle)
	return "But %s did not have enough mana!" % battler.name

func get_applied_text(battle: Battle) -> String:
	var battler := battler_resolver.resolve(battle)
	var amount := int(amount_resolver.resolve())
	return "%s spent %d mana..." % [battler.name, amount]
