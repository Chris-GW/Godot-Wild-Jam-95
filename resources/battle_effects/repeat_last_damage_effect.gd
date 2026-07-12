class_name RepeatLastDamageEffect
extends BattleEffect

@export
var repeat_count := 1

var _last_effect: BattleEffect = null
var _hit_count := 0

func apply(battle: Battle) -> void:
	_last_effect = battle.get_last_effect()
	if not _last_effect:
		CustomLogger.info("No effect to repeat!")
		return

	if not _last_effect.can_repeat():
		CustomLogger.info("Last effect cannot be repeated!")
		return

	if not _last_effect.did_deal_damage():
		CustomLogger.info("Last effect did not deal damage!")
		return

	CustomLogger.info("Repeating last damage effect %d time(s)..." % repeat_count)

	for i in repeat_count:
		_last_effect.apply(battle)

		if _last_effect.did_apply():
			_hit_count += 1

func did_apply() -> bool:
	return _hit_count > 0

func did_deal_damage() -> bool:
	return _last_effect and _last_effect.did_deal_damage()
