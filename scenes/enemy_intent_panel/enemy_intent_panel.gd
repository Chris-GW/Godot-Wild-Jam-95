@tool
class_name EnemyIntentPanel
extends PanelContainer

@export
var effect: BattleEffect:
	set(value):
		effect = value

		_refresh()

@onready
var attack_icon: TextureRect = %AttackIcon

@onready
var magic_icon: TextureRect = %MagicIcon

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	# TODO: ensure these criteria work for all possible attacks

	if attack_icon:
		attack_icon.visible = effect and effect.has_damage()

	if magic_icon:
		magic_icon.visible = effect and not effect.has_damage()
