@tool
extends Interactable

## The dialogue resource
@export var dialogue_resource: DialogueResource

## Start from a given title when using balloon as a [Node] in a scene.
@export var start_from_title: String = ""


func _init() -> void:
	self.action = func():
		DialogueManager.show_dialogue_balloon(dialogue_resource, start_from_title)
