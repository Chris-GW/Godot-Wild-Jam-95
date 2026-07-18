class_name BaseMap
extends Node2D

@onready var y_sort: Node2D = $YSort
@onready var player: Player = %Player
@onready var world_camera_2d: Camera2D = %WorldCamera2D


func _ready() -> void:
	$Parallax2D.show() # show infinte water only while running the game
	GameEvents.enemy_chasing.connect(_on_enemy_chasing)
	GameEvents.battle_ended.connect(_on_battle_ended)


func set_enter_node(enter_node_name: String) -> void:
	var enter_node := get_node(enter_node_name) as Node2D
	player.set_global_position(enter_node.global_position)


func _on_enemy_chasing() -> void:
	for interactable: Interactable in get_tree().get_nodes_in_group("interactable"):
		interactable.set_monitoring.call_deferred(false)

func _on_battle_ended(_is_won: bool) -> void:
	for interactable: Interactable in get_tree().get_nodes_in_group("interactable"):
		interactable.set_monitoring.call_deferred(true)
