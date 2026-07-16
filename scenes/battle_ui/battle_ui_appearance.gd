@tool
class_name BattleUIAppearance
extends Node

@export
var base_control: Control

@export
var text_panel: TextPanel

@export
var item_description_panel: ItemDescriptionPanel

@export
var enemy_battler_panel: BattlerPanel

@export
var enemy_battler_sprite_panel: BattlerSpritePanel

@export
var enemy_intent_panel: EnemyIntentPanel

@export
var player_battler_panel: BattlerPanel

@export
var player_battler_sprite_panel: BattlerSpritePanel

func for_shown() -> void:
	if base_control:
		base_control.show()

	if enemy_intent_panel:
		enemy_intent_panel.hide()

	if player_battler_panel:
		player_battler_panel.hide()

	if player_battler_sprite_panel:
		player_battler_sprite_panel.hide()

	if item_description_panel:
		item_description_panel.hide()

func for_hidden() -> void:
	if base_control:
		base_control.hide()

func set_enemy_effect(effect: BattleEffect) -> void:
	if enemy_intent_panel:
		enemy_intent_panel.effect = effect

func for_player_attack_requested() -> void:
	if enemy_intent_panel:
		# TODO: only do this the first time in each battle
		enemy_intent_panel.show()

	if player_battler_panel:
		# TODO: only do this the first time in each battle
		player_battler_panel.show()

	if player_battler_sprite_panel:
		# TODO: only do this the first time in each battle
		player_battler_sprite_panel.show()

	if item_description_panel:
		item_description_panel.show()

func for_player_attack_chosen() -> void:
	if item_description_panel:
		item_description_panel.hide()

func set_enemy(enemy: EnemyBattler) -> void:
	if enemy_battler_panel:
		enemy_battler_panel.battler = enemy

	if enemy_battler_sprite_panel:
		enemy_battler_sprite_panel.battler = enemy

func set_attack_considered(index: int) -> void:
	if item_description_panel:
		item_description_panel.item = Loadout.get_item(index)

func clear_battle_text() -> void:
	if text_panel:
		text_panel.clear_lines()

func add_battle_text(text: String) -> void:
	if text_panel:
		text_panel.add_line(text)
