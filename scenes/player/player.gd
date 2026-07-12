class_name Player
extends CharacterBody2D

enum State { PAUSED, ACTIVE }

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var step_sfx_player: AudioStreamPlayer = $StepSfxPlayer
@onready var step_sfx_timer: Timer = $StepSfxTimer

@export var move_speed: float
@export var move_smoothing: float

var _state_factory := PlayerStateFactory.new()
var _current_state: PlayerState = null

func _ready() -> void:
	switch_state(Player.State.ACTIVE)

func switch_state(state: Player.State, state_data := PlayerStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "PlayerStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func update_animation() -> void:
	if velocity.length_squared() > 30.0:
		var velocity_direction := velocity.normalized()
		animation_tree.set("parameters/idle/blend_position", velocity_direction)
		animation_tree.set("parameters/run/blend_position", velocity_direction)

		if step_sfx_timer.is_stopped():
			step_sfx_timer.start()
			step_sfx_player.play()
	else:
		step_sfx_timer.stop()
