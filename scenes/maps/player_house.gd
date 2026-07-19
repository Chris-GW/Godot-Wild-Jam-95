extends BaseMap

@onready
var world_teleporter: WorldTeleporter = %WorldTeleporter

func _ready() -> void:
	super._ready()

	if PlayerManager.prologue_wakeup:
		show_prologue_wakeup.call_deferred()
		PlayerManager.prologue_wakeup = false

func show_prologue_wakeup() -> void:
	var prologue_dialogue = load("res://resources/dialoge/prologue.dialogue")
	DialogueManager.show_dialogue_balloon(prologue_dialogue, "wakeup")

func start_world_transformation() -> void:
	world_teleporter.start_world_transformation()
