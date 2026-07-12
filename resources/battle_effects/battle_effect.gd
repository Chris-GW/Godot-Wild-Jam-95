## Class, to be extended, for applying an effect to a battle.
## E.g. damage the enemy, make the enemy skip their next turn, etc.
class_name BattleEffect
extends Resource

func apply(_battle: Battle) -> void:
	pass

func can_repeat() -> bool:
	return false

func did_apply() -> bool:
	return false

func did_deal_damage() -> bool:
	return false
