class_name RepeatEffectAttempt
extends EffectAttempt

var _attempts: Array[EffectAttempt]

func _init(effect: BattleEffect) -> void:
	_effect = effect

func add_attempt(attempt: EffectAttempt) -> void:
	_attempts.append(attempt)

func complete() -> void:
	attempt_text = _compute_attempt_text()

func _compute_attempt_text() -> String:
	var successful_attempts: Array[EffectAttempt] = _attempts.filter(_was_valid)

	if successful_attempts.size() <= 0:
		return "Tried to repeat the last effect %d time(s) but it didn't work!"

	var event_texts: Array[String] = [
		"Repeated the last effect %d time(s):" % successful_attempts.size()
	]

	for i in successful_attempts.size():
		event_texts.append(successful_attempts[i].attempt_text)

	return "\n".join(event_texts)

func _was_valid(attempt: EffectAttempt) -> bool:
	return attempt.target_was_valid

func get_effect() -> BattleEffect:
	return _effect
