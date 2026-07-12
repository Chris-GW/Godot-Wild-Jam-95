@tool
class_name BattleUIAppearance
extends Node

@export
var base_control: Control

@export
var text_panel: TextPanel

func for_shown() -> void:
	if base_control:
		base_control.show()

func for_hidden() -> void:
	if base_control:
		base_control.hide()

func clear_battle_text() -> void:
	if text_panel:
		text_panel.clear_lines()

func add_battle_text(text: String) -> void:
	if text_panel:
		text_panel.add_line(text)
