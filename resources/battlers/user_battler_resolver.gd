class_name UserBattlerResolver
extends BattlerResolver

func resolve(battle: Battle) -> Battler:
	if battle.is_enemy_turn():
		return battle.enemy

	return battle.player
