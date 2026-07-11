class_name Player 
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var step_sfx_player: AudioStreamPlayer = $StepSfxPlayer
@onready var step_sfx_timer: Timer = $StepSfxTimer

@export var move_speed: float
@export var move_smoothing: float


func _ready() -> void:
	# looping step sfx on timeout
	step_sfx_timer.timeout.connect(step_sfx_player.play)


func _physics_process(delta: float) -> void:
	_update_movement_velocity(delta)
	_update_animation()
	move_and_slide()


func _update_movement_velocity(delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity_weight := 1.0 - exp(-move_smoothing * delta)
	var target_velocity := input_direction * move_speed
	velocity = velocity.lerp(target_velocity, velocity_weight)

func _update_animation() -> void:
	if velocity.length_squared() > 30.0:
		var velocity_direction := velocity.normalized()
		animation_tree.set("parameters/idle/blend_position", velocity_direction)
		animation_tree.set("parameters/run/blend_position", velocity_direction)
		
		if step_sfx_timer.is_stopped():
			step_sfx_timer.start()
			step_sfx_player.play()
	else:
		step_sfx_timer.stop()
