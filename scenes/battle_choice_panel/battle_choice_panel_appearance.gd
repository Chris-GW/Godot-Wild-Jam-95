class_name BattleChoicePanelAppearance
extends Node

@export
var base_control: Control

@export
var empty_label: Label

@export
var choose_action_label: Label

@export
var rows_parent: VBoxContainer

var _rows: Array[BattleChoiceRow] = []

func _ready() -> void:
	for c: BattleChoiceRow in rows_parent.get_children():
		_rows.append(c)

func for_shown() -> void:
	if base_control:
		base_control.show()

func for_hidden() -> void:
	if base_control:
		base_control.hide()

func set_choices(items: Array[Item]) -> void:
	if items.size() <= 0:
		empty_label.show()
		choose_action_label.hide()
		rows_parent.hide()
	else:
		empty_label.hide()
		choose_action_label.show()
		rows_parent.show()

	for i in _rows.size():
		if items.size() > i:
			_rows[i].item = items[i]
			_rows[i].show()
		else:
			_rows[i].item = null
			_rows[i].hide()

func set_selected_index(index: int) -> void:
	for i in _rows.size():
		if index == i:
			_rows[i].to_selected()
		else:
			_rows[i].to_idle()
