@tool
class_name BattleUIAppearance
extends Node

@export
var base_control: Control

@export
var text_panel: TextPanel

@export
var enemy_battler_panel: BattlerPanel

@export
var player_battler_panel: BattlerPanel

func for_shown() -> void:
	if base_control:
		base_control.show()

	if player_battler_panel:
		player_battler_panel.hide()

func for_hidden() -> void:
	if base_control:
		base_control.hide()

func show_player_panel() -> void:
	if player_battler_panel:
		player_battler_panel.show()

func set_enemy(enemy: EnemyBattler) -> void:
	if enemy_battler_panel:
		enemy_battler_panel.battler = enemy

func clear_battle_text() -> void:
	if text_panel:
		text_panel.clear_lines()

func add_battle_text(text: String) -> void:
	if text_panel:
		text_panel.add_line(text)
