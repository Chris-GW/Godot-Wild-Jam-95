## Class, to be extended, for determining whether an effect can be applied to a
## battle. E.g. player needs enough mana points.
class_name EffectRequirement
extends Resource

func is_satisfied(_battle: Battle) -> bool:
	return false

func apply(_battle: Battle) -> void:
	pass

func get_failed_text(_battle: Battle) -> String:
	return ""

func get_applied_text(_battle: Battle) -> String:
	return ""
