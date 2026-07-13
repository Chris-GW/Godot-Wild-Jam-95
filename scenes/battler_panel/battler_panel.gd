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

@onready
var mp_label: Label = %MPLabel

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if name_label:
		name_label.text = battler.name if battler else "<battler_name>"

	if hp_label:
		hp_label.text = _compute_hp_text()

	if mp_label:
		mp_label.visible = not battler or battler.has_mana_pool()
		mp_label.text = _compute_mp_text()

func _compute_hp_text() -> String:
	if not battler:
		return "HP: N/A"

	return "HP: %d/%d" % [battler.health.current_health, battler.health.max_health]

func _compute_mp_text() -> String:
	if not battler:
		return "MP: N/A"

	if not battler.has_mana_pool():
		return "MP: N/A"

	var mana_pool := battler.get_mana_pool()
	return "MP: %d/%d" % [mana_pool.current_points, mana_pool.max_points]
