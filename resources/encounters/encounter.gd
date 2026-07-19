class_name Encounter
extends Resource

@export
var enemy: EnemyBattler

@export
var reward: Item

@export
var enemy_defeated_dialogue: DialogueResource

@export
var start_from_title: String

@export
var prerequisites: Array[Encounter] = []

signal enemy_defeated

func finish(is_won: bool) -> void:
	if is_won:
		if enemy_defeated_dialogue:
			DialogueManager.show_dialogue_balloon(
				enemy_defeated_dialogue,
				start_from_title)

			await DialogueManager.dialogue_ended

		if reward:
			Inventory.add(reward)

			GameEvents.emit_reward_gained(reward)

		enemy_defeated.emit()
	else:
		GameEvents.emit_player_defeated()

	GameEvents.emit_encounter_ended()
