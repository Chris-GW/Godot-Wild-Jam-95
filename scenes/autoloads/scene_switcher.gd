extends Node

const SCENE_GAME := preload("res://main.tscn")

func _ready() -> void:
	SignalHelper.persist(
		GameEvents.game_started,
		_on_game_started)

func _on_game_started() -> void:
	get_tree().change_scene_to_packed(SCENE_GAME)
