class_name EffectWithQueueAttempt
extends EffectAttempt

var _child_attempt: EffectAttempt = null
var _queue: Array[BattleEffect] = []

func set_child_attempt(child_attempt: EffectAttempt) -> void:
	_child_attempt = child_attempt

func set_queue(queue: Array[BattleEffect]) -> void:
	_queue = queue

func complete() -> void:
	if _child_attempt:
		attempt_texts.append_array(_child_attempt.attempt_texts)

func has_queue() -> bool:
	return true

func get_queue() -> Array[BattleEffect]:
	return _queue
