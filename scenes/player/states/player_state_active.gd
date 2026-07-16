class_name PlayerStateActive
extends PlayerState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now active" % _player.name)

	# looping step sfx on timeout
	SignalHelper.persist(_player.step_sfx_timer.timeout, _play_step_sfx)

	SignalHelper.once(
		GameEvents.inventory_shown,
		_to_paused)

	SignalHelper.once(
		GameEvents.battle_started,
		_to_paused)
	
	var dialogue_manager := Engine.get_singleton("DialogueManager") as DialogueManager
	SignalHelper.once(
		dialogue_manager.dialogue_started, 
		func(_args): _to_paused())

func _to_paused() -> void:
	transition_state(Player.State.PAUSED)

func _physics_process(delta: float) -> void:
	_update_movement_velocity(delta)
	_player.update_animation()
	_player.move_and_slide()

func _update_movement_velocity(delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity_weight := 1.0 - exp(-_player.move_smoothing * delta)
	var target_velocity := input_direction * _player.move_speed
	_player.velocity = _player.velocity.lerp(target_velocity, velocity_weight)

func _play_step_sfx() -> void:
	_player.step_sfx_player.play()


func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("interact") and _can_interact()):
		_player._interactables.front().interact()

func _can_interact() -> bool:
	return not _player._interactables.is_empty()
