@tool
class_name Interactable
extends Area2D

@onready var action_label: Label = $ActionLabel

@export var action_name: String = "[E] to interact": 
	set = set_action_name

var action: Callable = func():
	pass


func _ready() -> void:
	action_label.text = action_name
	action_label.visible = Engine.is_editor_hint()


func interact() -> void:
	if action.is_valid():
		action.call()


func grab_interaction_focus() -> void:
	action_label.show()

func release_interaction_focus() -> void:
	action_label.hide()

func has_interaction_focus() -> bool:
	return action_label.visible


func set_action_name(_action_name: String) -> void:
	action_name = _action_name
	if is_node_ready():
		action_label.text = action_name


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.register_interactable(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.unregister_interactable(self)
		release_interaction_focus()
