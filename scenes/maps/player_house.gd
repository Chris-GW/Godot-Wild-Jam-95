extends BaseMap

@onready var world_teleporter: WorldTeleporter = %WorldTeleporter
@onready var discord_notification_sfx: AudioStreamPlayer = $DiscordNotificationSfx
@onready var pc_interaction_sfx: AudioStreamPlayer = $PcInteractionSfx
@onready var exit_player_home: Interactable = %ExitPlayerHome
@onready var pc_interaction_area_2d: Interactable = %PcInteractionArea2D


func _ready() -> void:
	super._ready()
	
	await get_tree().process_frame
	if PlayerManager.prologue_wakeup:
		show_prologue_wakeup()
	if PlayerManager.is_back_home:
		# lock him up for lasst pc interaction
		exit_player_home.set_monitoring.call_deferred(false)


func show_prologue_wakeup() -> void:
	var prologue_dialogue = load("res://resources/dialoge/prologue.dialogue")
	DialogueManager.show_dialogue_balloon(prologue_dialogue, "wakeup")
	PlayerManager.prologue_wakeup = false


func start_world_transformation() -> void:
	world_teleporter.start_world_transformation()


func play_discord_notification_sfx() -> void:
	discord_notification_sfx.play()
	await discord_notification_sfx.finished


func play_pc_keyboard_sfx() -> void:
	for i in 3:
		pc_interaction_sfx.play()
		await pc_interaction_sfx.finished


func do_end_game() -> void:
	var main_menu := "res://scenes/main_menu/main_menu.tscn"
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color.BLACK, 4.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(main_menu)).set_delay(1.5)
