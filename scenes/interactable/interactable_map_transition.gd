@tool
extends Interactable

@export_file("*.tscn") var enter_scene: String
@export var enter_node_name: String


func _init() -> void:
	self.action = func():
		GameEvents.emit_map_transition_requested(enter_scene, enter_node_name)
