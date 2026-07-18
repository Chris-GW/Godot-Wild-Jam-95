extends BaseMap


## The dialogue resource
@export var dialogue_resource: DialogueResource
## Start from a given title when using balloon as a [Node] in a scene.
@export var start_from_title: String = ""

@onready
var mp3_player_boo_area: Area2D = %Mp3PlayerBooArea

func _ready() -> void:
	SignalHelper.once(
		mp3_player_boo_area.body_entered,
		_on_mp3_player_boo_area_body_entered)

func _on_mp3_player_boo_area_body_entered(body: Node2D) -> void:
	if body is Player:
		DialogueManager.show_dialogue_balloon(dialogue_resource, start_from_title)
