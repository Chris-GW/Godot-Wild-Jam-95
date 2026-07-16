class_name BaseMap
extends Node2D

@onready var y_sort: Node2D = $YSort
@onready var player: Player = %Player
@onready var world_camera_2d: Camera2D = %WorldCamera2D


func _ready() -> void:
	$Parallax2D.show() # show infinte water only while running the game


func set_enter_node(enter_node_name: String) -> void:
	var enter_node := get_node(enter_node_name) as Node2D
	player.set_global_position(enter_node.global_position)
