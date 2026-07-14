class_name OpponentBattlerResolver
extends BattlerResolver

func resolve(battle: Battle) -> Battler:
	if battle.is_enemy_turn():
		return battle.player

	return battle.enemy
