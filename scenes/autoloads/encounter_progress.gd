extends Node

var _completed_encounters: Array[Encounter] = []

func complete(encounter: Encounter) -> void:
	if not _completed_encounters.has(encounter):
		_completed_encounters.append(encounter)

func is_available(encounter: Encounter) -> bool:
	if _completed_encounters.has(encounter):
		return false

	if encounter.prerequisites.is_empty():
		return true

	return encounter.prerequisites.all(is_complete)

func is_complete(encounter: Encounter) -> bool:
	return _completed_encounters.has(encounter)
