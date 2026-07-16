extends BaseMap


func _ready() -> void:
	super._ready()
	if PlayerManager.prologue_wakeup:
		show_prologue_wakeup.call_deferred()
		PlayerManager.prologue_wakeup = false


func show_prologue_wakeup() -> void:
	var prologue_dialogue = load("res://resources/dialoge/prologue.dialogue")
	DialogueManager.show_dialogue_balloon(prologue_dialogue, "wakeup")

func start_world_transformation() -> void:
	var tween := create_tween()
	tween.set_loops()
	tween.tween_callback(animate_random_map_colors)
	tween.tween_interval(0.5)
	await DialogueManager.dialogue_ended
	tween.kill()
	self.modulate = Color.WHITE
	GameEvents.emit_map_transition_requested("res://scenes/maps/new_player_home.tscn")

func animate_random_map_colors() -> void:
	create_tween().tween_property(self, "modulate", Color(randf(), randf(), randf()), 1.0)
