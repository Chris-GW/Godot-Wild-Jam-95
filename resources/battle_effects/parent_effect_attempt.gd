class_name ParentEffectAttempt
extends EffectAttempt

var _child_attempt: EffectAttempt = null

func set_child_attempt(child_attempt: EffectAttempt) -> void:
	_child_attempt = child_attempt

func complete() -> void:
	if _child_attempt:
		attempt_texts.append_array(_child_attempt.attempt_texts)
