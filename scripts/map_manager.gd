class_name WorldMapManager
extends Node2D

@onready var current_map: BaseMap = $CurrentMap
@onready var player: Player = %Player
@onready var world_camera_2d: Camera2D = %WorldCamera2D


func _ready() -> void:
	GameEvents.map_transition_requested.connect(_on_map_transition_requested)
	player.reparent(current_map.y_sort)
	player.global_position = current_map.player_spawn.global_position


func transition_map_to(map: BaseMap, enter_node_name: String) -> void:
	player.get_parent().remove_child(player)
	remove_child(current_map)
	current_map.queue_free()
	
	current_map = map
	add_child(map)
	map.y_sort.add_child(player)
	var enter_node = current_map.get_node(enter_node_name)
	player.velocity = Vector2.ZERO
	player.global_position = enter_node.global_position


func _on_map_transition_requested(map_scene_path: String, enter_node_name: String) -> void:
	var map_resource := ResourceLoader.load(map_scene_path) as PackedScene
	var map := map_resource.instantiate() as BaseMap
	transition_map_to.call_deferred(map, enter_node_name)
