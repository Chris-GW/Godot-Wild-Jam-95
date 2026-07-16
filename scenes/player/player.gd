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
var _interactables: Array[Interactable] = []


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


func register_interactable(interactable: Interactable) -> void:
	_interactables.append(interactable)
	_focus_nearest_interactable()

func unregister_interactable(interactable: Interactable) -> void:
	_interactables.erase(interactable)
	_focus_nearest_interactable()

func _focus_nearest_interactable() -> Interactable:
	var nearest_interactable: Interactable = null
	_interactables.sort_custom(by_player_distance)
	for interactable: Interactable in _interactables:
		if nearest_interactable == null:
			nearest_interactable = interactable
			nearest_interactable.grab_interaction_focus()
		else:
			interactable.release_interaction_focus()
	return nearest_interactable

func by_player_distance(a: Node2D, b: Node2D) -> bool:
	var distance_a := global_position.distance_squared_to(a.global_position)
	var distance_b := global_position.distance_squared_to(b.global_position)
	return distance_a < distance_b
