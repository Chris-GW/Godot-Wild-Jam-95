@tool
class_name BattlerPanel
extends PanelContainer

@export
var battler: Battler:
	set(value):
		battler = value

		SignalHelper.on_changed(battler, _refresh)

		_refresh()

@onready
var name_label: Label = %NameLabel

@onready
var hp_label: Label = %HPLabel

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if name_label:
		name_label.text = battler.name if battler else "<battler_name>"

	if hp_label:
		hp_label.text = _compute_hp_text()

func _compute_hp_text() -> String:
	if not battler:
		return "HP: N/A"

	return "HP: %d/%d" % [battler.health.current_health, battler.health.max_health]
