class_name BaseMap
extends Node2D

@onready var y_sort: Node2D = $YSort
@onready var player: Player = %Player
@onready var world_camera_2d: Camera2D = %WorldCamera2D


@export var camera_smoothing: float


func _ready() -> void:
	$Parallax2D.show() # show infinte water only while running the game
	GameEvents.enemy_chasing.connect(_on_enemy_chasing)
	GameEvents.battle_ended.connect(_on_battle_ended)
	world_camera_2d.global_position = player.global_position


func _process(delta: float) -> void:
	_camera_follow_player(delta)


func _camera_follow_player(delta: float) -> void:
	var weight := 1.0 - exp(-camera_smoothing * delta)
	var camera_position := world_camera_2d.global_position
	camera_position = camera_position.lerp(player.global_position, weight)
	world_camera_2d.global_position = camera_position


func set_enter_node(enter_node_name: String) -> void:
	var enter_node := get_node(enter_node_name) as Node2D
	player.global_position = enter_node.global_position
	world_camera_2d.global_position = player.global_position


func _on_enemy_chasing(_enemy_entity: EnemyEntity) -> void:
	for interactable: Interactable in get_tree().get_nodes_in_group("interactable"):
		interactable.set_monitoring.call_deferred(false)

func _on_battle_ended(_is_won: bool) -> void:
	for interactable: Interactable in get_tree().get_nodes_in_group("interactable"):
		interactable.set_monitoring.call_deferred(true)
