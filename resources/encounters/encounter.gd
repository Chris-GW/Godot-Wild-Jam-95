class_name Encounter
extends Resource

@export
var enemy: EnemyBattler

@export
var enemy_defeated_dialogue: DialogueResource

@export
var start_from_title: String

signal enemy_defeated

func finish(is_won: bool) -> void:
	if is_won:
		enemy_defeated.emit()

		if enemy_defeated_dialogue:
			DialogueManager.show_dialogue_balloon(
				enemy_defeated_dialogue,
				start_from_title)
