class_name PlayerStatePaused
extends PlayerState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now paused" % _player.name)

	SignalHelper.once(
		GameEvents.inventory_hidden,
		_to_active)

	SignalHelper.once(
		GameEvents.encounter_ended,
		_on_encounter_ended)

	var dialogue_manager := Engine.get_singleton("DialogueManager") as DialogueManager
	SignalHelper.once(
		dialogue_manager.dialogue_ended,
		func(_args): _to_active())

func _on_encounter_ended() -> void:
	_to_active()

func _to_active() -> void:
	transition_state(Player.State.ACTIVE)

func _physics_process(delta: float) -> void:
	_decelerate(delta)

	_player.update_animation()
	_player.move_and_slide()

func _decelerate(delta: float) -> void:
	var velocity_weight := 1.0 - exp(-_player.move_smoothing * delta)
	var target_velocity := Vector2.ZERO

	_player.velocity = _player.velocity.lerp(target_velocity, velocity_weight)
