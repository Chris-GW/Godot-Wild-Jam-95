class_name DamageEnemyEffect
extends BattleEffect

@export
var damage_resolver: NumberResolver

var _did_hit := false

func apply(battle: Battle) -> void:
	if not damage_resolver:
		CustomLogger.info("No damage resolver is set")
		return

	if battle.enemy:
		battle.enemy.take_damage(damage_resolver)
		_did_hit = true

func can_repeat() -> bool:
	return true

func did_apply() -> bool:
	return _did_hit

func did_deal_damage() -> bool:
	return _did_hit
