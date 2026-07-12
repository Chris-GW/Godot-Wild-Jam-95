class_name PlayerStateActive
extends PlayerState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now active" % _player.name)

	# looping step sfx on timeout
	_player.step_sfx_timer.timeout.connect(_player.step_sfx_player.play)

	SignalHelper.once(
		GameEvents.inventory_shown,
		transition_state.bind(Player.State.PAUSED))

func _exit_tree() -> void:
	_player.step_sfx_timer.timeout.disconnect(_player.step_sfx_player.play)

func _physics_process(delta: float) -> void:
	_update_movement_velocity(delta)

	_player.update_animation()
	_player.move_and_slide()

func _update_movement_velocity(delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity_weight := 1.0 - exp(-_player.move_smoothing * delta)
	var target_velocity := input_direction * _player.move_speed
	_player.velocity = _player.velocity.lerp(target_velocity, velocity_weight)
