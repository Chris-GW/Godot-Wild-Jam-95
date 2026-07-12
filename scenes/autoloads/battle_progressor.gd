class_name BattleProgressor
extends Node

const START_WAIT_DURATION := 1.0
const TURN_WAIT_DURATION := 0.5
const END_WAIT_DURATION := 2.0

@export
var battle: Battle

func _process(_delta: float) -> void:
	for i in 4:
		if Input.is_action_just_pressed("player_attack_%d" % i):
			GameEvents.emit_player_attack_chosen(i)

func start() -> void:
	if battle and battle.try_start():
		SignalHelper.persist(battle.event_occurred, _send_battle_text)
		SignalHelper.once(battle.ended, _on_battle_ended)

		GameEvents.emit_battle_started()

		SignalHelper.once_next_frame(_send_start_text)
		SignalHelper.once_after(START_WAIT_DURATION, _wait_for_player_choice)

func _send_start_text() -> void:
	_send_battle_text("Battle vs %s started!" % battle.enemy.name)

func _wait_for_player_choice() -> void:
	SignalHelper.once(
		GameEvents.player_attack_chosen,
		_on_player_attack_chosen)

	_send_battle_text("Waiting for player choice... (1/2/3/4)")

func _on_player_attack_chosen(index: int) -> void:
	battle.do_player_turn(index)

	await get_tree().create_timer(TURN_WAIT_DURATION).timeout

	if battle.check_ended():
		return

	await get_tree().create_timer(TURN_WAIT_DURATION).timeout

	battle.do_enemy_turn()

	await get_tree().create_timer(TURN_WAIT_DURATION).timeout

	if battle.check_ended():
		return

	await get_tree().create_timer(TURN_WAIT_DURATION).timeout

	_wait_for_player_choice()

func _on_battle_ended(winner: Battler) -> void:
	await get_tree().create_timer(TURN_WAIT_DURATION).timeout

	_send_battle_text("%s won the battle!" % winner.name)

	await get_tree().create_timer(END_WAIT_DURATION).timeout

	GameEvents.emit_battle_ended()

	queue_free()

func _send_battle_text(battle_text: String) -> void:
	CustomLogger.info(battle_text)
	GameEvents.emit_battle_text_created(battle_text)
