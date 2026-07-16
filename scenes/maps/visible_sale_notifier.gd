extends VisibleOnScreenNotifier2D

## The dialogue resource
@export var dialogue_resource: DialogueResource

## Start from a given title when using balloon as a [Node] in a scene.
@export var start_from_title: String = ""


func _ready() -> void:
	SignalHelper.once(screen_entered, on_screen_entered)


func on_screen_entered() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, start_from_title)
	queue_free()
