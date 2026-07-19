@tool
extends Interactable

@export_file("*.tscn") var enter_scene: String
@export var enter_node_name: String
@export var with_door_sound := false

func _init() -> void:
	self.action = func():
		if with_door_sound:
			SoundManager.play_door_sfx()
		GameEvents.emit_map_transition_requested(enter_scene, enter_node_name)
