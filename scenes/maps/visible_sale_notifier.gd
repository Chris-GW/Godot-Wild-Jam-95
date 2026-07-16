extends VisibleOnScreenNotifier2D

## The dialogue resource
@export var dialogue_resource: DialogueResource

## Start from a given title when using balloon as a [Node] in a scene.
@export var start_from_title: String = ""


func _ready() -> void:
	SignalHelper.once(screen_entered, on_sale_spotted)


func on_sale_spotted() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, start_from_title)
	queue_free()
