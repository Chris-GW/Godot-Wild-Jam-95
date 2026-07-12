class_name EffectAttempt

var _effect: BattleEffect

var target: Battler = null
var target_was_valid := false
var did_hit := false
var damage_dealt := 0
var attempt_text := ""

func _init(effect: BattleEffect) -> void:
	_effect = effect

func get_effect() -> BattleEffect:
	return _effect

func can_repeat() -> bool:
	return _effect and _effect.can_repeat()
