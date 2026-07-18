extends BaseMap


## The dialogue resource
@export var dialogue_resource: DialogueResource
## Start from a given title when using balloon as a [Node] in a scene.
@export var start_from_title: String = ""


func _on_mp_3_player_boo_area_body_entered(body: Node2D) -> void:
	if body is Player:
		DialogueManager.show_dialogue_balloon(dialogue_resource, start_from_title)
