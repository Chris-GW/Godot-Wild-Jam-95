class_name PlayerStatePaused
extends PlayerState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now paused" % _player.name)

	SignalHelper.once(
		GameEvents.inventory_hidden,
		transition_state.bind(Player.State.ACTIVE))

func _physics_process(delta: float) -> void:
	_decelerate(delta)

	_player.update_animation()
	_player.move_and_slide()

func _decelerate(delta: float) -> void:
	var velocity_weight := 1.0 - exp(-_player.move_smoothing * delta)
	var target_velocity := Vector2.ZERO

	_player.velocity = _player.velocity.lerp(target_velocity, velocity_weight)
