class_name WorldMapManager
extends Node2D

@onready var current_map: BaseMap = $CurrentMap


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN # hide mouse
	GameEvents.map_transition_requested.connect(_on_map_transition_requested)
	DialogueManager.get_current_scene = func():
		return current_map


func transition_map_to(map: BaseMap, enter_node_name: String = "") -> void:
	remove_child(current_map)
	current_map.queue_free()
	current_map = map
	add_child(map)
	if not enter_node_name.is_empty():
		map.set_enter_node(enter_node_name)


func _on_map_transition_requested(map_scene_path: String, enter_node_name: String) -> void:
	var map_resource := ResourceLoader.load(map_scene_path) as PackedScene
	var map := map_resource.instantiate() as BaseMap
	transition_map_to.call_deferred(map, enter_node_name)
