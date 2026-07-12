class_name EnemyBattlerResolver
extends BattlerResolver

func resolve(battle: Battle) -> Battler:
	return battle.enemy
