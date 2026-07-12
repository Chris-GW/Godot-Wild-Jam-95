extends Area2D

@export_file("*.tscn") var enter_scene: String
@export var enter_node_name: String


func _ready() -> void:
	self.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameEvents.emit_map_transition_requested(enter_scene, enter_node_name)
