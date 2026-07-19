class_name WorldTeleporter
extends Node

@export
var target: Node2D

@export_file("*.tscn")
var destination_scene: String

var _is_playing_dialogue := false

func _ready() -> void:
	SignalHelper.persist(
		DialogueManager.dialogue_started,
		_on_dialogue_started)

	SignalHelper.persist(
		DialogueManager.dialogue_ended,
		_on_dialogue_ended)

func _on_dialogue_started(_resource: DialogueResource) -> void:
	_is_playing_dialogue = true

func _on_dialogue_ended(_resource: DialogueResource) -> void:
	_is_playing_dialogue = false

func start_world_transformation() -> void:
	var tween := create_tween()
	tween.set_loops()
	tween.tween_callback(_animate_random_map_colors)
	tween.tween_interval(0.5)

	if _is_playing_dialogue:
		await DialogueManager.dialogue_ended

	tween.kill()
	target.modulate = Color.WHITE

	GameEvents.emit_map_transition_requested(destination_scene)

func _animate_random_map_colors() -> void:
	create_tween().tween_property(target, "modulate", Color(randf(), randf(), randf()), 1.0)
