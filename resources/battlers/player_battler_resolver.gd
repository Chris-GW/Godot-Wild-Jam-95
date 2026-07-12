class_name PlayerBattlerResolver
extends BattlerResolver

func resolve(battle: Battle) -> Battler:
	return battle.player
