extends BaseMap

@export
var enemy_sequence: Array[EnemyEntity] = []

func _ready() -> void:
	enemy_sequence = enemy_sequence.filter(
		func(e: EnemyEntity) -> bool:
			return not EncounterProgress.is_complete(e.encounter)
	)

	for i in enemy_sequence.size():
		if i == 0:
			_enable_enemy(enemy_sequence[i])
		else:
			_disable_enemy(enemy_sequence[i])

func _enable_enemy(enemy: EnemyEntity) -> void:
	enemy.monitoring = true

	SignalHelper.once(
		enemy.defeated,
		_on_enemy_defeated.bind(enemy))

func _disable_enemy(enemy: EnemyEntity) -> void:
	enemy.monitoring = false

func _on_enemy_defeated(enemy: EnemyEntity) -> void:
	EncounterProgress.complete(enemy.encounter)

	enemy_sequence.erase(enemy)

	if not enemy_sequence.is_empty():
		var next_enemy: EnemyEntity = enemy_sequence.front()
		CustomLogger.debug("Next enemy is %s" % enemy.encounter.enemy.name)

		_enable_enemy(next_enemy)
