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
		if enemy_defeated_dialogue:
			DialogueManager.show_dialogue_balloon(
				enemy_defeated_dialogue,
				start_from_title)

			await DialogueManager.dialogue_ended

		enemy_defeated.emit()

	GameEvents.emit_encounter_ended()
