@tool
class_name BattlerSpritePanel
extends PanelContainer

@export
var battler: Battler:
	set(value):
		battler = value

		SignalHelper.on_changed(battler, _refresh)

		_refresh()

@onready
var texture_rect: TextureRect = %TextureRect

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if texture_rect:
		if battler and battler.sprite:
			texture_rect.texture = battler.sprite
			show()
		else:
			texture_rect.texture = null
			hide()

func _compute_texture() -> Texture2D:
	return battler.sprite if battler else null
