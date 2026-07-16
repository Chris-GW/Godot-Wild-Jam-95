## Class, to be extended, for applying an effect to a battle.
## E.g. damage the enemy, make the enemy skip their next turn, etc.
@tool
class_name BattleEffect
extends Resource

func resolve_effect() -> BattleEffect:
	return self

func apply(_battle: Battle) -> EffectAttempt:
	return null

func can_apply(_battle: Battle) -> bool:
	return false

func can_repeat() -> bool:
	return false

func has_damage() -> bool:
	return false

func has_healing() -> bool:
	return false
